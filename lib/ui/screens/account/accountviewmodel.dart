import 'package:build_byte/app/app.locator.dart';
import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/models/addressmodel.dart';
import 'package:build_byte/services/address_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Accountviewmodel extends BaseViewModel {
  final _addressService = locator<AddressService>();
  final _navigationService = locator<NavigationService>();

  List<AddressModel> addresses = [];

  AddressModel? get selectedAddress {
    for (final a in addresses) {
      if (a.isSelected) return a;
    }
    return null;
  }

  Future<void> loadAddress() async {
    setBusy(true);
    addresses = await _addressService.getAddresses();
    setBusy(false);
  }

  void addNewAddress() {
    _navigationService.navigateTo(Routes.addAddressview);
  }

  void editAddress(AddressModel address) {
    _navigationService.navigateTo(Routes.addAddressview);
  }
}
