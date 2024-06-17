import 'package:firebase_core/firebase_core.dart';
import 'package:flixid_course/data/repositories/authentication_repository.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FirebaseAuthentication implements AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthentication({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    try {
      var userCrendetial = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Result.success(userCrendetial.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message!);
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();

    if (_firebaseAuth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed('failed to sign out');
    }
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return Result.success(userCredential.user!.uid);
    } on FirebaseException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}
