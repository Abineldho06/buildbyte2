import 'package:build_byte/models/addressmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:build_byte/app/app.locator.dart';
import 'package:build_byte/services/address_service.dart';
import 'package:stacked_services/stacked_services.dart';

class AddAddressviewmodel extends BaseViewModel {
  final _addressService = locator<AddressService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  final namecntrl = TextEditingController();
  final phonecntrl = TextEditingController();
  final housenamecntrl = TextEditingController();
  final areacntrl = TextEditingController();
  final landmarkcntrl = TextEditingController();
  final pincodecntrl = TextEditingController();
  final towncntrl = TextEditingController();
  final statecntrl = TextEditingController();

  final namenode = FocusNode();
  final phonenode = FocusNode();
  final housenamenode = FocusNode();
  final areanode = FocusNode();
  final landmarknode = FocusNode();
  final pincodenode = FocusNode();
  final townnode = FocusNode();
  final statenode = FocusNode();

  final formkey = GlobalKey<FormState>();

  Future<void> saveAddress() async {
    if (!formkey.currentState!.validate()) return;

    setBusy(true);

    await _addressService.addAddress(
      AddressModel(
        id: '',
        username: namecntrl.text.trim(),
        mobile: phonecntrl.text.trim(),
        houseName: housenamecntrl.text.trim(),
        area: areacntrl.text.trim(),
        landmark: landmarkcntrl.text.trim(),
        pincode: pincodecntrl.text.trim(),
        town: towncntrl.text.trim(),
        state: statecntrl.text.trim(),
        isSelected: true,
      ),
    );

    setBusy(false);
    _navigationService.back();

    _snackbarService.showSnackbar(
      message: 'Login successful',
      duration: Duration(seconds: 3),
      backgroundColor: Colors.greenAccent,
    );
  }

  @override
  void dispose() {
    namecntrl.dispose();
    phonecntrl.dispose();
    housenamecntrl.dispose();
    areacntrl.dispose();
    landmarkcntrl.dispose();
    pincodecntrl.dispose();
    towncntrl.dispose();
    statecntrl.dispose();

    namenode.dispose();
    phonenode.dispose();
    housenamenode.dispose();
    areanode.dispose();
    landmarknode.dispose();
    pincodenode.dispose();
    townnode.dispose();
    statenode.dispose();
    super.dispose();
  }
}
