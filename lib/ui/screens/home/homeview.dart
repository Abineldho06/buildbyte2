import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/app/utils.dart';
import 'package:build_byte/constants/assets.gen.dart';
import 'package:build_byte/ui/screens/home/homeviewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (viewmodel) {},
      viewModelBuilder: () {
        return HomeViewModel();
      },
      builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
        var user = FirebaseAuth.instance.currentUser!;
        return Scaffold(
          appBar: AppBar(title: Text("Home")),
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Assets.images.background2.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    children: [
                      Column(
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              user.email![0].toUpperCase(),
                              style: GoogleFonts.montserrat(
                                fontSize: 36,
                                fontWeight: .bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${user.email}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Account'),
                  onTap: () {
                    viewModel.naviagtetoAccount();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Sign out'),
                  onTap: () {
                    viewModel.signout();
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: TextButton(
              onPressed: () {
                navigationService.navigateTo(Routes.addAddressview);
              },
              child: Text("Add Address"),
            ),
          ),
        );
      },
    );
  }
}
