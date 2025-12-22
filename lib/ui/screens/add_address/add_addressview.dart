import 'package:build_byte/ui/screens/add_address/add_addressviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class AddAddressview extends StatelessWidget {
  const AddAddressview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddAddressviewmodel>.reactive(
      viewModelBuilder: () {
        return AddAddressviewmodel();
      },
      builder:
          (BuildContext context, AddAddressviewmodel viewModel, Widget? child) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(title: Text("Address")),
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 1,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                      key: viewModel.formkey,
                      child: Column(
                        mainAxisAlignment: .center,
                        spacing: 20,
                        children: [
                          textfield(
                            viewModel,
                            controller: viewModel.namecntrl,
                            labelText: 'Name',
                            focusNode: viewModel.namenode,
                            hintText: 'enter your name',
                            onTapOutside: (_) {
                              viewModel.namenode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else if (value.length < 3) {
                                return 'user name must contain morethan 3 letter';
                              } else {
                                return null;
                              }
                            },
                          ),
                          textfield(
                            viewModel,
                            controller: viewModel.phonecntrl,
                            labelText: 'Phone',
                            focusNode: viewModel.phonenode,
                            hintText: 'enter your phone number',
                            onTapOutside: (_) {
                              viewModel.phonenode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else if (value.length != 10) {
                                return 'invalid Phone number';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          textfield(
                            viewModel,
                            controller: viewModel.housenamecntrl,
                            labelText: 'Home',
                            focusNode: viewModel.housenamenode,
                            hintText: 'enter your home/office details',
                            onTapOutside: (_) {
                              viewModel.housenamenode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else if (value.length < 3) {
                                return 'give a valid address';
                              } else {
                                return null;
                              }
                            },
                          ),
                          textfield(
                            viewModel,
                            controller: viewModel.areacntrl,
                            labelText: 'Area',
                            focusNode: viewModel.areanode,
                            hintText: 'enter your area / city',
                            onTapOutside: (_) {
                              viewModel.areanode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else if (value.length < 3) {
                                return 'enter a valid place';
                              } else {
                                return null;
                              }
                            },
                          ),
                          textfield(
                            viewModel,
                            controller: viewModel.landmarkcntrl,
                            labelText: 'Landmark',
                            focusNode: viewModel.landmarknode,
                            hintText: 'enter your landmark',
                            onTapOutside: (_) {
                              viewModel.landmarknode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else {
                                return null;
                              }
                            },
                          ),
                          textfield(
                            viewModel,
                            controller: viewModel.pincodecntrl,
                            labelText: 'Pincode',
                            focusNode: viewModel.pincodenode,
                            hintText: 'enter your pincode',
                            onTapOutside: (_) {
                              viewModel.pincodenode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else if (value.length < 6 || value.length > 6) {
                                return 'enter a valid pincode';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          textfield(
                            viewModel,
                            controller: viewModel.towncntrl,
                            labelText: 'Town',
                            focusNode: viewModel.townnode,
                            hintText: 'enter your town / city',
                            onTapOutside: (_) {
                              viewModel.townnode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else if (value.length < 3) {
                                return 'enter a valid town name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          textfield(
                            viewModel,
                            controller: viewModel.statecntrl,
                            labelText: 'State',
                            focusNode: viewModel.statenode,
                            hintText: 'enter your state',
                            onTapOutside: (_) {
                              viewModel.statenode.unfocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please fill this field';
                              } else if (value.length < 3) {
                                return 'enter a valid state';
                              } else {
                                return null;
                              }
                            },
                          ),

                          GestureDetector(
                            onTap: () {
                              viewModel.isBusy ? null : viewModel.saveAddress();
                            },
                            child: Container(
                              width: double.infinity,

                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: viewModel.isBusy
                                  ? Center(
                                      child: CircleAvatar(
                                        foregroundColor: Colors.black,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Save Address',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: .bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
    );
  }

  Widget textfield(
    AddAddressviewmodel viewModel, {
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    required FocusNode focusNode,
    required String hintText,
    required void Function(PointerDownEvent) onTapOutside,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white70),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepOrangeAccent),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white24,
        errorStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
      ),
      obscureText: obscureText,
      onTapOutside: onTapOutside,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
