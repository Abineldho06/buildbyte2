import 'package:build_byte/models/addressmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference get _addressRef =>
      _db.collection('users').doc(_uid).collection('addresses');

  /// Get all addresses
  Future<List<AddressModel>> getAddresses() async {
    final snapshot = await _addressRef.get();

    return snapshot.docs
        .map(
          (doc) =>
              AddressModel.fromMap(doc.id, doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  /// Add new address (auto select)
  Future<void> addAddress(AddressModel address) async {
    final snapshot = await _addressRef.get();

    // Unselect existing addresses
    for (var doc in snapshot.docs) {
      await doc.reference.update({'isSelected': false});
    }

    await _addressRef.add(address.toMap());
  }

  /// Update existing address
  Future<void> updateAddress(AddressModel address) async {
    await _addressRef.doc(address.id).update({
      'username': address.username,
      'mobile': address.mobile,
      'houseName': address.houseName,
      'area': address.area,
      'landmark': address.landmark,
      'pincode': address.pincode,
      'town': address.town,
      'state': address.state,
    });
  }
}
