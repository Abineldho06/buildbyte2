import 'package:build_byte/app/utils.dart';
import 'package:build_byte/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:build_byte/app/app.locator.dart';
import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/services/authservice.dart';

class LoginViewModel extends BaseViewModel {
  ///Services Object.
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  ///Controllers.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ///FocusNodes.
  final FocusNode emailnode = FocusNode();
  final FocusNode passnode = FocusNode();

  bool isobsure = true;

  final formKey = GlobalKey<FormState>();

  ///Email Validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  ///Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  ///Password Obscure Text
  void obscuretext() {
    isobsure = !isobsure;
    notifyListeners();
  }

  ///Login Function
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    setBusy(true);

    try {
      final user = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        _snackbarService.showSnackbar(
          message: 'Login successful',
          duration: Duration(seconds: 3),
          backgroundColor: Colors.greenAccent,
        );

        _navigationService.clearStackAndShow(Routes.homeview);
      } else {
        _snackbarService.showSnackbar(
          message: 'Invalid email or password',
          duration: Duration(seconds: 3),
          backgroundColor: Palette.bgcolor,
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Invalid email or password',
        duration: Duration(seconds: 3),
        backgroundColor: Palette.bgcolor,
      );
    }

    setBusy(false);
  }

  void goToSignUp() {
    _navigationService.navigateToSignUpView();
  }

  ///Foregot Password Screen Navigation
  void navigateToForgotpassview() {
    navigationService.navigateTo(Routes.forgotpassview);
  }
}
