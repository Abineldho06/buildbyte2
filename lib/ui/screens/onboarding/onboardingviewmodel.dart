import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/app/utils.dart';
import 'package:build_byte/constants/assets.gen.dart';
import 'package:stacked/stacked.dart';

class Onboardingviewmodel extends BaseViewModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  //Onboarding Screen Data.
  final List<Map<String, dynamic>> onboardingData = [
    {
      "image": Assets.images.onb1.provider(),
      "description": "Choose the right components without confusion.",
    },
    {
      "image": Assets.images.onb2.provider(),
      "description":
          "Get expert guidance and clear support at every step of your PC build.",
    },
    {
      "image": Assets.images.onb3.provider(),
      "description":
          "Build your dream PC with confidence, clarity, and complete control.",
    },
  ];

  //Button tap Function
  void nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _currentIndex++;
      notifyListeners();
    } else {
      navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    }
  }
}
