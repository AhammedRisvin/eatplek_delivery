import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';
import '../services/store.dart';

/// Custom HTTP client — mirrors FittorConnect from the customer app.
/// 403 = expired token (silent refresh + retry)
/// 401 = missing/invalid token (kick to login)
class FittorConnect {
  FittorConnect._();
  static final FittorConnect _instance = FittorConnect._();
  factory FittorConnect() => _instance;

  static const Duration _timeout = Duration(seconds: 30);

  String _token = '';

  // Refresh lock — prevents multiple concurrent refresh calls
  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  void setToken(String token) {
    _token = token;
    _log('Token set: ${token.substring(0, token.length.clamp(0, 20))}...');
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token.isNotEmpty) 'Authorization': 'Bearer $_token',
      };

  // ─── Public Methods ────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> get(String path) async {
    return _execute(
        () => http.get(_uri(path), headers: _headers).timeout(_timeout), path);
  }

  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? body}) async {
    return _execute(
        () => http
            .post(_uri(path), headers: _headers, body: jsonEncode(body ?? {}))
            .timeout(_timeout),
        path);
  }

  Future<Map<String, dynamic>> put(String path,
      {Map<String, dynamic>? body}) async {
    return _execute(
        () => http
            .put(_uri(path), headers: _headers, body: jsonEncode(body ?? {}))
            .timeout(_timeout),
        path);
  }

  Future<Map<String, dynamic>> patch(String path,
      {Map<String, dynamic>? body}) async {
    return _execute(
        () => http
            .patch(_uri(path), headers: _headers, body: jsonEncode(body ?? {}))
            .timeout(_timeout),
        path);
  }

  Future<Map<String, dynamic>> delete(String path,
      {Map<String, dynamic>? body}) async {
    return _execute(
        () => http
            .delete(_uri(path),
                headers: _headers, body: body != null ? jsonEncode(body) : null)
            .timeout(_timeout),
        path);
  }

  // ─── Private ──────────────────────────────────────────────────────────────

  Uri _uri(String path) => Uri.parse('${ApiEndpoints.baseUrl}$path');

  Future<Map<String, dynamic>> _execute(
    Future<http.Response> Function() call,
    String path,
  ) async {
    http.Response response = await call();
    _log('${response.statusCode} $path');

    if (response.statusCode == 403) {
      // Expired token — attempt silent refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        response = await call(); // retry with new token
        _log('RETRY ${response.statusCode} $path');
      } else {
        _onSessionExpired();
        throw 'Session expired. Please login again.';
      }
    }

    if (response.statusCode == 401) {
      _onSessionExpired();
      throw 'Unauthorized. Please login.';
    }

    return _parseResponse(response);
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body as Map<String, dynamic>;
    }
    // 400-level errors: throw the message string so catch blocks can inspect it
    final message = body['message'] ?? body['error'] ?? 'Something went wrong';
    throw message.toString();
  }

  Future<bool> _refreshToken() async {
    if (_isRefreshing) {
      // Wait for the existing refresh to complete
      return await _refreshCompleter!.future;
    }
    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      final refreshToken = Store.refreshToken;
      if (refreshToken.isEmpty) {
        _refreshCompleter!.complete(false);
        return false;
      }

      final response = await http
          .post(
            _uri(ApiEndpoints.refreshToken),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refreshToken': refreshToken}),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final newAccess = data['accessToken'] as String? ?? '';
        final newRefresh = data['refreshToken'] as String? ?? '';

        if (newAccess.isNotEmpty) {
          await Store.saveTokens(
              accessToken: newAccess, refreshToken: newRefresh);
          setToken(newAccess);
          _refreshCompleter!.complete(true);
          return true;
        }
      }
      _refreshCompleter!.complete(false);
      return false;
    } catch (e) {
      _log('Refresh failed: $e');
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  void _onSessionExpired() async {
    await Store.clearAll();
    setToken('');
    // Navigation handled by the controller that catches the exception
    _log('Session expired — tokens cleared');
  }

  void _log(String msg) {
    // ignore: avoid_print
    print('[FittorConnect] $msg');
  }
}
