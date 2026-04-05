import 'package:shared_preferences/shared_preferences.dart';

class Store {
  Store._();

  static late SharedPreferences _prefs;

  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyName = 'name';
  static const String _keyPhone = 'phone';
  static const String _keyDeliveryPartnerId = 'delivery_partner_id';
  static const String _keyIsOnline = 'is_online';
  static const String _keyFcmToken = 'fcm_token';
  static const String _keyPartnerType = 'partner_type';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Tokens
  static String get accessToken => _prefs.getString(_keyAccessToken) ?? '';
  static set accessToken(String v) => _prefs.setString(_keyAccessToken, v);

  static String get refreshToken => _prefs.getString(_keyRefreshToken) ?? '';
  static set refreshToken(String v) => _prefs.setString(_keyRefreshToken, v);

  static Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) async {
    await Future.wait([
      _prefs.setString(_keyAccessToken, accessToken),
      _prefs.setString(_keyRefreshToken, refreshToken),
    ]);
  }

  static Future<void> clearTokens() async {
    await Future.wait(
        [_prefs.remove(_keyAccessToken), _prefs.remove(_keyRefreshToken)]);
  }

  // User info
  static String get name => _prefs.getString(_keyName) ?? '';
  static set name(String v) => _prefs.setString(_keyName, v);

  static String get phone => _prefs.getString(_keyPhone) ?? '';
  static set phone(String v) => _prefs.setString(_keyPhone, v);

  static String get deliveryPartnerId =>
      _prefs.getString(_keyDeliveryPartnerId) ?? '';
  static set deliveryPartnerId(String v) =>
      _prefs.setString(_keyDeliveryPartnerId, v);

  static bool get isOnline => _prefs.getBool(_keyIsOnline) ?? false;
  static set isOnline(bool v) => _prefs.setBool(_keyIsOnline, v);

  static String get fcmToken => _prefs.getString(_keyFcmToken) ?? '';
  static set fcmToken(String v) => _prefs.setString(_keyFcmToken, v);

  static String get partnerType =>
      _prefs.getString(_keyPartnerType) ?? 'vendor';
  static set partnerType(String v) => _prefs.setString(_keyPartnerType, v);

  static bool get isLoggedIn => accessToken.isNotEmpty;

  static Future<void> clearAll() async => await _prefs.clear();
}
