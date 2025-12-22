import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/app/utils.dart';
import 'package:build_byte/services/authservice.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  AuthService auth = AuthService();

  void naviagtetoAccount() {
    navigationService.navigateTo(Routes.accountview);
  }

  void signout() {
    auth.logout();
    navigationService.clearStackAndShow(Routes.loginView);
  }
}
