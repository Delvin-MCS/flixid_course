import 'package:flixid_course/data/repositories/authentication_repository.dart';
import 'package:flixid_course/data/repositories/user_repository.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/entities/user.dart';
import 'package:flixid_course/domain/usecases/usecase.dart';

part 'login_params.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  Login({required this.authenticationRepository, required this.userRepository});

  @override
  Future<Result<User>> call(LoginParams params) async {
    var idResult = await authenticationRepository.login(
        email: params.email, password: params.password);

    if (idResult is Success) {
      var userResult = await userRepository.getUser(uid: idResult.resultValue!);

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message),
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
