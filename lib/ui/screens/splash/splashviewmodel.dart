import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/app/utils.dart';
import 'package:build_byte/services/authservice.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  AuthService user = AuthService();

  //Navigation to onboarding screen.
  init() {
    Future.delayed(Duration(seconds: 3), () {
      if (user.currentUser != null) {
        navigationService.clearStackAndShow(Routes.homeview);
      } else {
        navigationService.clearStackAndShow(Routes.onboardingview);
      }
    });
  }
}
