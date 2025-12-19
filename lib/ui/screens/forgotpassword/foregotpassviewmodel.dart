import 'package:build_byte/app/app.locator.dart';
import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/app/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class Foregotpassviewmodel extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();

  final TextEditingController emailcontroller = TextEditingController();
  Future<void> sendemail() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailcontroller.text.trim(),
    );
    _snackbarService.showSnackbar(
      message: 'Password reset link sent to your email',
      backgroundColor: Colors.green,
    );
    navigationService.navigateTo(Routes.loginView);
  }
}
