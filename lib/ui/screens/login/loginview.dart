import 'dart:ui';

import 'package:build_byte/constants/app_colors.dart';
import 'package:build_byte/constants/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'loginviewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () {
        return LoginViewModel();
      },
      builder: (BuildContext context, LoginViewModel viewModel, Widget? child) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.background.provider(),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Palette.trasperant,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'Sign In',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: .bold,
                          fontSize: 36,
                        ),
                      ),
                      SizedBox(height: 16),
                      Form(
                        key: viewModel.formKey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * .57,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                  width: 1.2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: .end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 16,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: .center,
                                      children: [
                                        /// Email
                                        emailfield(viewModel),
                                        const SizedBox(height: 16),

                                        /// Password
                                        passwordfield(viewModel),

                                        ///Foregot Password.
                                        foregotpassButton(viewModel),

                                        const SizedBox(height: 16),

                                        /// Login Button
                                        loginButton(viewModel),

                                        const SizedBox(height: 16),

                                        /// Go to Sign Up.
                                        signupButton(viewModel),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * .12,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: Assets.images.onb3.provider(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///Password Field
  Widget passwordfield(LoginViewModel viewModel) {
    return textfield(
      viewModel,
      controller: viewModel.passwordController,
      labelText: 'Password',
      validator: viewModel.validatePassword,
      focusNode: viewModel.passnode,
      hintText: 'enter your password',
      obscureText: viewModel.isobsure,
      onTapOutside: (event) {
        viewModel.passnode.unfocus();
      },
      suffixIcon: IconButton(
        onPressed: () {
          viewModel.obscuretext();
        },
        icon: viewModel.isobsure
            ? Icon(Icons.visibility, color: Colors.white70)
            : Icon(Icons.visibility_off, color: Colors.white70),
      ),
    );
  }

  ///Email Field
  Widget emailfield(LoginViewModel viewModel) {
    return textfield(
      viewModel,
      controller: viewModel.emailController,
      labelText: 'Email',
      validator: viewModel.validateEmail,
      focusNode: viewModel.emailnode,
      hintText: 'enter your e-mail',
      onTapOutside: (event) {
        viewModel.emailnode.unfocus();
      },
    );
  }

  ///Foregot Password Button
  Widget foregotpassButton(LoginViewModel viewModel) {
    return Align(
      alignment: .centerRight,
      child: TextButton(
        onPressed: () {
          viewModel.navigateToForgotpassview();
        },
        child: Text(
          "Forgot Password?",
          style: GoogleFonts.montserrat(
            color: Colors.deepOrangeAccent,
            fontWeight: .w500,
          ),
        ),
      ),
    );
  }

  ///Sign Up Button
  Widget signupButton(LoginViewModel viewModel) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          'Don’t have an account? ',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            viewModel.goToSignUp();
          },
          child: Text(
            "Sign Up",
            style: GoogleFonts.montserrat(
              color: Colors.deepOrange,
              fontWeight: .bold,
            ),
          ),
        ),
      ],
    );
  }

  ///Login Button
  Widget loginButton(LoginViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.login();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent,
              Colors.deepOrange,
              Colors.deepOrangeAccent,
            ],
          ),
        ),
        child: Center(
          child: viewModel.isBusy
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  "Login",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: .bold,
                  ),
                ),
        ),
      ),
    );
  }

  ///TextField Section
  Widget textfield(
    LoginViewModel viewModel, {
    required TextEditingController? controller,
    required String labelText,
    String? Function(String?)? validator,
    required FocusNode focusNode,
    required String hintText,
    required void Function(PointerDownEvent) onTapOutside,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white70),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.deepOrangeAccent),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white24,
        errorStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
      ),
      obscureText: obscureText,
      onTapOutside: onTapOutside,
      validator: validator,
    );
  }
}
