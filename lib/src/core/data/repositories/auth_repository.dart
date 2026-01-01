import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schedule_management/src/core/data/models/user_model.dart';
import 'package:schedule_management/src/core/utils/constants/app_secreet.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  Future<void> initialize() async {
    await _googleSignIn.initialize(
      clientId: AppSecreet.clientId,
      serverClientId: AppSecreet.serverClientId,
    );
  }

  Stream<UserModel?> get userStream {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (userDoc.exists) {
        return UserModel.fromFirestore(userDoc);
      }

      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
    });
  }

  Stream<String?> get idTokenStream {
    return _firebaseAuth.idTokenChanges().asyncMap((user) async {
      if (user == null) return null;
      return await user.getIdToken();
    });
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final userDoc =
            await _firestore.collection('users').doc(firebaseUser.uid).get();

        if (!userDoc.exists) {
          final newUser = UserModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: firebaseUser.displayName,
            photoUrl: firebaseUser.photoURL,
            createdAt: DateTime.now(),
          );
          await _firestore
              .collection('users')
              .doc(firebaseUser.uid)
              .set(newUser.toFirestore());
          return newUser;
        } else {
          return UserModel.fromFirestore(userDoc);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    final userDoc =
        await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (userDoc.exists) {
      return UserModel.fromFirestore(userDoc);
    }
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }
}
