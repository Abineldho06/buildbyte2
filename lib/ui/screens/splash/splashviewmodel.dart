import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/app/utils.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  //Navigation to onboarding screen.
  init() {
    Future.delayed(Duration(seconds: 3), () {
      navigationService.pushNamedAndRemoveUntil(Routes.onboardingview);
    });
  }
}
