class AddressModel {
  final String id;
  final String username;
  final String mobile;
  final String houseName;
  final String area;
  final String landmark;
  final String pincode;
  final String town;
  final String state;
  final bool isSelected;

  AddressModel({
    required this.id,
    required this.username,
    required this.mobile,
    required this.houseName,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.town,
    required this.state,
    required this.isSelected,
  });

  factory AddressModel.fromMap(String id, Map<String, dynamic> data) {
    return AddressModel(
      id: id,
      username: data['username'],
      mobile: data['mobile'],
      houseName: data['houseName'],
      area: data['area'],
      landmark: data['landmark'],
      pincode: data['pincode'],
      town: data['town'],
      state: data['state'],
      isSelected: data['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'mobile': mobile,
      'houseName': houseName,
      'area': area,
      'landmark': landmark,
      'pincode': pincode,
      'town': town,
      'state': state,
      'isSelected': isSelected,
      'createdAt': DateTime.now(),
    };
  }
}
