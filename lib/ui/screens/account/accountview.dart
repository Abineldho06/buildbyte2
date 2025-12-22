import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/app/utils.dart';
import 'package:build_byte/ui/screens/account/accountviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Accountview extends StatelessWidget {
  const Accountview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Accountviewmodel>.reactive(
      onViewModelReady: (viewModel) {
        viewModel.loadAddress();
      },
      viewModelBuilder: () {
        return Accountviewmodel();
      },
      builder:
          (BuildContext context, Accountviewmodel viewModel, Widget? child) {
            return Scaffold(
              appBar: AppBar(title: Text("Account")),
              body: viewModel.isBusy
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                  : viewModel.selectedAddress == null
                  ? addaddress(viewModel)
                  : isAddressAvailable(viewModel),
            );
          },
    );
  }

  Widget addaddress(Accountviewmodel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text("No Account Details Available"),
          ElevatedButton(
            onPressed: () async {
              await navigationService.navigateTo(Routes.addAddressview);
              viewModel.loadAddress();
            },
            child: Text('Add Address'),
          ),
        ],
      ),
    );
  }

  Widget isAddressAvailable(Accountviewmodel viewModel) {
    var address = viewModel.selectedAddress!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            address.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(address.mobile),
          const SizedBox(height: 8),
          Text(address.houseName),
          Text(address.area),
          if (address.landmark.isNotEmpty)
            Text('Landmark: ${address.landmark}'),
          const SizedBox(height: 6),
          Text('${address.town}, ${address.state} - ${address.pincode}'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              viewModel.editAddress(address);
            },
            child: const Text('Edit Address'),
          ),
        ],
      ),
    );
  }
}
