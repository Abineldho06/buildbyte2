import 'package:build_byte/constants/app_colors.dart';
import 'package:build_byte/constants/assets.gen.dart';
import 'package:build_byte/ui/screens/login/loginview.dart';
import 'package:build_byte/ui/screens/onboarding/onboardingviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class Onboardingview extends StatelessWidget {
  const Onboardingview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Onboardingviewmodel>.reactive(
      viewModelBuilder: () => Onboardingviewmodel(),
      builder: (context, viewModel, child) {
        final data = viewModel.onboardingData[viewModel.currentIndex];

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: data['image'] as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Palette.trasperant,
            body: body(context, data, viewModel),
          ),
        );
      },
    );
  }

  //Body
  Widget body(
    BuildContext context,
    Map<String, dynamic> data,
    Onboardingviewmodel viewModel,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black12,
            Colors.black12,
            Colors.black26,
            Colors.black54,
            Colors.black87,
            Colors.black87,
          ],
          begin: .topCenter,
          end: .bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            const Spacer(),
            const SizedBox(height: 76),
            // Description and Indicator
            descriptionandindicator(data, viewModel),
            const SizedBox(height: 24),
            //Next Button
            Button(viewModel, context),
          ],
        ),
      ),
    );
  }

  //Button
  Widget Button(Onboardingviewmodel viewModel, BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.nextPage();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Palette.scaffoldBackgroundColor,
        ),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * .06,
        child: Center(
          child: Text(
            viewModel.currentIndex == viewModel.onboardingData.length - 1
                ? "Explore"
                : "Next",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Palette.labeltextcolor,
              fontWeight: .bold,
            ),
          ),
        ),
      ),
    );
  }

  //Description and Indicator
  Widget descriptionandindicator(
    Map<String, dynamic> data,
    Onboardingviewmodel viewModel,
  ) {
    return Column(
      children: [
        Text(
          data["description"]!,
          style: GoogleFonts.montserrat(
            fontSize: 26,
            fontWeight: .bold,
            color: Palette.scaffoldBackgroundColor,
          ),
        ),

        SizedBox(height: 46),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            viewModel.onboardingData.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: viewModel.currentIndex == index ? 20 : 8,
              decoration: BoxDecoration(
                color: viewModel.currentIndex == index
                    ? Palette.scaffoldBackgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
