import 'package:flixid_course/data/repositories/authentication_repository.dart';
import 'package:flixid_course/data/repositories/user_repository.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/entities/user.dart';
import 'package:flixid_course/domain/usecases/register/register_param.dart';
import 'package:flixid_course/domain/usecases/usecase.dart';

class Register implements UseCase<Result<User>, RegisterParam> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  Register(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(RegisterParam params) async {
    var uidResult = await _authenticationRepository.register(
        email: params.email, password: params.password);

    if (uidResult.isSuccess) {
      var userResult = await _userRepository.createUser(
          uid: uidResult.resultValue!,
          email: params.email,
          name: params.name,
          photoUrl: params.photoUrl);

      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return Result.failed(uidResult.errorMessage!);
    }
  }
}
