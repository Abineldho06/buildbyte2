import 'package:build_byte/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:build_byte/app/app.locator.dart';
import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/services/authservice.dart';

class SignUpViewModel extends BaseViewModel {
  ///Services Object.
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  ///Controllers.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ///FocusNodes.
  final FocusNode emaifnode = FocusNode();
  final FocusNode passfnode = FocusNode();
  final FocusNode repassfnode = FocusNode();

  ///FormKey for Validation.
  final formKey = GlobalKey<FormState>();

  bool passisobscure = true;
  bool repassisobscure = true;

  ///Email Validation.
  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Enter an e-mail';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Invalid e-mail';
    } else {
      return null;
    }
  }

  ///Password Validation.
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

  ///Confirm Password Validation
  String? confirmpassvalidation(String? value) {
    if (value == null || value.isEmpty) {
      return 're-enter confirm password';
    } else if (value != passwordController.text.trim()) {
      return 'password not match';
    } else {
      return null;
    }
  }

  ///Obscure text.
  void passobscureText() {
    passisobscure = !passisobscure;
    notifyListeners();
  }

  ///re-pass Obscure.
  void repassobscureText() {
    repassisobscure = !repassisobscure;
    notifyListeners();
  }

  ///Dispose.
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emaifnode.dispose();
    passfnode.dispose();
    repassfnode.dispose();
    super.dispose();
  }

  ///SignUp Function.
  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);

      try {
        final user = await _authService.signUp(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        if (user != null) {
          _snackbarService.showSnackbar(
            message: "User registered successfully",
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
          );

          _navigationService.clearStackAndShow(Routes.loginView);
        } else {
          _snackbarService.showSnackbar(
            message: "User registration failed",
            duration: const Duration(seconds: 3),
            backgroundColor: Palette.bgcolor,
          );
        }
      } catch (e) {
        _snackbarService.showSnackbar(
          message: "User already exists",
          duration: const Duration(seconds: 3),
          backgroundColor: Palette.bgcolor,
        );
      }

      setBusy(false);
    }
  }
}
