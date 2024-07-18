import 'package:flixid_course/data/repositories/authentication_repository.dart';
import 'package:flixid_course/data/repositories/user_repository.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/entities/user.dart';
import 'package:flixid_course/domain/usecases/usecase.dart';

class GetLoggedInUser implements UseCase<Result<User>, void> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  GetLoggedInUser(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(void _) async {
    String? loggedId = _authenticationRepository.getLoggedInUserId();
    if (loggedId != null) {
      var userResult = await _userRepository.getUser(uid: loggedId);

      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return const Result.failed("No user logged in");
    }
  }
}
