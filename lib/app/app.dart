import 'package:build_byte/services/authservice.dart';
import 'package:build_byte/ui/screens/forgotpassword/forgotpassview.dart';
import 'package:build_byte/ui/screens/login/loginview.dart';
import 'package:build_byte/ui/screens/onboarding/onboardingview.dart';
import 'package:build_byte/ui/screens/signup/signupview.dart';
import 'package:build_byte/ui/screens/splash/splashview.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_services.dart';
import '../services/user_service.dart';
import '../ui/screens/home/homeview.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: Splashview, initial: true),
    MaterialRoute(page: Homeview),
    MaterialRoute(page: Onboardingview),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: Forgotpassview),
  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: AuthService),
  ],
)
class AppSetUp {}
