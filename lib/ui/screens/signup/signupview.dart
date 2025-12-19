import 'dart:ui';

import 'package:build_byte/constants/app_colors.dart';
import 'package:build_byte/constants/assets.gen.dart';
import 'package:build_byte/ui/screens/signup/signupviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () {
        return SignUpViewModel();
      },
      builder:
          (BuildContext context, SignUpViewModel viewModel, Widget? child) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.background.provider(),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                backgroundColor: Palette.trasperant,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'Sign up',
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
                                filter: ImageFilter.blur(
                                  sigmaX: 15,
                                  sigmaY: 15,
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * .65,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: .end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisAlignment: .center,
                                          children: [
                                            /// Email
                                            emailfield(viewModel),
                                            const SizedBox(height: 16),

                                            /// Password
                                            passfield(viewModel),
                                            const SizedBox(height: 16),

                                            /// Confirm Password
                                            confirmpassfield(viewModel),
                                            const SizedBox(height: 30),

                                            /// Sign Up Button
                                            button(viewModel),
                                            SizedBox(height: 16),

                                            ///Already have an account
                                            signupButton(viewModel),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 40),
                                      Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                            .12,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Assets.images.onb3
                                                .provider(),
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

  ///Email Filed
  Widget emailfield(SignUpViewModel viewModel) {
    return textfield(
      viewModel,
      controller: viewModel.emailController,
      focusNode: viewModel.emaifnode,
      labelText: 'Email',
      hintText: 'enter your e-mail',
      onTapOutside: (event) {
        viewModel.emaifnode.unfocus();
      },
      validator: viewModel.validateEmail,
    );
  }

  ///Password Field
  Widget passfield(SignUpViewModel viewModel) {
    return textfield(
      viewModel,
      controller: viewModel.passwordController,
      focusNode: viewModel.passfnode,
      labelText: 'Password',
      hintText: 'enter a password',
      obscureText: viewModel.passisobscure,
      onTapOutside: (event) {
        viewModel.passfnode.unfocus();
      },
      validator: viewModel.validatePassword,
      suffixIcon: IconButton(
        onPressed: () {
          viewModel.passobscureText();
        },
        icon: viewModel.passisobscure
            ? Icon(Icons.visibility, color: Colors.white70)
            : Icon(Icons.visibility_off, color: Colors.white70),
      ),
    );
  }

  ///Confirm Password Field
  Widget confirmpassfield(SignUpViewModel viewModel) {
    return textfield(
      viewModel,
      controller: viewModel.confirmPasswordController,
      focusNode: viewModel.repassfnode,
      labelText: 'Confirm Password',
      validator: viewModel.confirmpassvalidation,
      hintText: 're-enter password',
      obscureText: viewModel.repassisobscure,
      onTapOutside: (event) {
        viewModel.repassfnode.unfocus();
      },
      suffixIcon: IconButton(
        onPressed: () {
          viewModel.repassobscureText();
        },
        icon: viewModel.repassisobscure
            ? Icon(Icons.visibility, color: Colors.white70)
            : Icon(Icons.visibility_off, color: Colors.white70),
      ),
    );
  }

  //Button
  Widget button(SignUpViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.signUp();
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
                  "Sign up",
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

  Widget signupButton(SignUpViewModel viewModel) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          'Already have an account? ',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            viewModel.gotoLoginScreen();
          },
          child: Text(
            "Sign In",
            style: GoogleFonts.montserrat(
              color: Colors.deepOrange,
              fontWeight: .bold,
            ),
          ),
        ),
      ],
    );
  }

  ///Text Field Widget
  Widget textfield(
    SignUpViewModel viewModel, {
    required TextEditingController controller,
    required FocusNode? focusNode,
    required String labelText,
    required String hintText,
    bool obscureText = false,
    required void Function(PointerDownEvent)? onTapOutside,
    required String? Function(String?)? validator,
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
