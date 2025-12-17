import 'package:build_byte/constants/app_colors.dart';
import 'package:build_byte/constants/assets.gen.dart';
import 'package:build_byte/ui/screens/splash/splashviewmodel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class Splashview extends StatelessWidget {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onDispose: (model) {},
      onViewModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () {
        return SplashViewModel();
      },
      builder:
          (BuildContext context, SplashViewModel viewModel, Widget? child) {
            return Scaffold(
              backgroundColor: Palette.scaffoldBackgroundColor,
              body: body(context),
            );
          },
    );
  }

  //body
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [logo(context), appnametext()],
    );
  }

  //App Name Section
  Widget appnametext() {
    return Text(
      'Build Byte',
      style: GoogleFonts.poppins(fontWeight: .bold, fontSize: 35),
    );
  }

  //Logo Section
  Widget logo(BuildContext context) {
    return Center(
      child: Assets.images.logoBlack.image(
        height: MediaQuery.sizeOf(context).height * .16,
        width: MediaQuery.sizeOf(context).width * .29,
        fit: BoxFit.fill,
      ),
    );
  }
}
