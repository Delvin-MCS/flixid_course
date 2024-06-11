import 'package:flixid_course/domain/entities/result.dart';

abstract interface class AuthenticationRepository {
  Future<Result<String>> register(
      {required String email, required String password});

  Future<Result<String>> login(
      {required String email, required String password});

  Future<Result<void>> logout();

  String? getLoggedInUserId();
}
