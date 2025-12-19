import 'package:build_byte/constants/app_colors.dart';
import 'package:flutter/material.dart';
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
        return Scaffold(
          appBar: AppBar(title: const Text("Login")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  /// Email
                  emailfield(viewModel),
                  const SizedBox(height: 16),

                  /// Password
                  passwordfield(viewModel),
                  const SizedBox(height: 30),

                  /// Login Button
                  loginButton(viewModel),

                  const SizedBox(height: 16),

                  /// Go to Sign Up.
                  signupButton(viewModel),

                  ///Foregot Password.
                  foregotpassButton(viewModel),
                ],
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
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off),
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
    return TextButton(
      onPressed: () {
        viewModel.navigateToForgotpassview();
      },
      child: const Text("Forgot Password?"),
    );
  }

  ///Sign Up Button
  Widget signupButton(LoginViewModel viewModel) {
    return TextButton(
      onPressed: viewModel.goToSignUp,
      child: const Text("Don’t have an account? Sign Up"),
    );
  }

  ///Login Button
  Widget loginButton(LoginViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: viewModel.isBusy ? null : viewModel.login,
        child: viewModel.isBusy
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Login"),
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
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Palette.labeltextcolor),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepOrangeAccent),
        ),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      onTapOutside: onTapOutside,
      validator: validator,
    );
  }
}
