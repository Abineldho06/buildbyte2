import 'package:build_byte/services/address_service.dart';
import 'package:build_byte/services/authservice.dart';
import 'package:build_byte/ui/screens/forgotpassword/forgotpassview.dart';
import 'package:build_byte/ui/screens/home/homeview.dart';
import 'package:build_byte/ui/screens/login/loginview.dart';
import 'package:build_byte/ui/screens/onboarding/onboardingview.dart';
import 'package:build_byte/ui/screens/signup/signupview.dart';
import 'package:build_byte/ui/screens/splash/splashview.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_services.dart';
import '../services/user_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: Splashview, initial: true),
    MaterialRoute(page: Onboardingview),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: Forgotpassview),
    MaterialRoute(page: Homeview),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: AddressService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: UserService),
  ],
)
class AppSetUp {}
