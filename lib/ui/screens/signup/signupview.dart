import 'package:build_byte/constants/app_colors.dart';
import 'package:build_byte/ui/screens/signup/signupviewmodel.dart';
import 'package:flutter/material.dart';
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
            return Scaffold(
              appBar: AppBar(title: const Text("Sign Up")),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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

                      if (viewModel.hasError) ...[
                        const SizedBox(height: 12),
                        Text(
                          viewModel.modelError.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ],
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
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off),
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
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off),
      ),
    );
  }

  //Button
  SizedBox button(SignUpViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: viewModel.isBusy
            ? null
            : () {
                viewModel.signUp();
              },
        child: viewModel.isBusy
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Create Account"),
      ),
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
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
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
