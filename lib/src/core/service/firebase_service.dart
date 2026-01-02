import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_management/src/core/data/models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore;

  FirebaseService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  }

  Future<void> saveUser(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.id)
        .set(user.toFirestore(), SetOptions(merge: true));
  }

  Stream<UserModel?> getUserStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);
  }
}
