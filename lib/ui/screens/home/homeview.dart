import 'package:build_byte/ui/screens/home/homeviewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Homeview extends StatelessWidget {
  late String username;
  Homeview({required this.username});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (viewmodel) {
        viewmodel.fetchdata();
      },
      viewModelBuilder: () {
        return HomeViewModel(username: username);
      },
      builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: Text("Hai ${viewModel.username}")),
        );
      },
    );
  }
}
