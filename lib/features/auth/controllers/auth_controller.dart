import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    update(['auth_password']);
  }

  Future<void> login(String partnerType) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || !email.contains('@')) {
      _setError('Enter a valid email address');
      return;
    }
    if (password.length < 4) {
      _setError('Enter your password');
      return;
    }

    _setLoading(true);
    _setError('');

    // Dummy login — simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _setLoading(false);
    Get.offAllNamed(AppRoutes.bottomNav);
  }

  void _setLoading(bool v) {
    _isLoading = v;
    update(['auth']);
  }

  void _setError(String v) {
    _errorMessage = v;
    update(['auth']);
  }
}
