import 'package:build_byte/ui/screens/forgotpassword/foregotpassviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Forgotpassview extends StatelessWidget {
  const Forgotpassview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Foregotpassviewmodel>.reactive(
      viewModelBuilder: () {
        return Foregotpassviewmodel();
      },
      builder:
          (
            BuildContext context,
            Foregotpassviewmodel viewModel,
            Widget? child,
          ) {
            return Scaffold(
              appBar: AppBar(title: const Text("Forgot Password")),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: viewModel.emailcontroller,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter registered email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        viewModel.sendemail();
                      },
                      child: const Text("Send Reset Link"),
                    ),
                  ],
                ),
              ),
            );
          },
    );
  }
}
