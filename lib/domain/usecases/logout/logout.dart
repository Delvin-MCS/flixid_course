import 'package:flixid_course/data/repositories/authentication_repository.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final AuthenticationRepository _authenticationRepository;

  Logout({required AuthenticationRepository authencitation})
      : _authenticationRepository = authencitation;

  @override
  Future<Result<void>> call(void _) {
    return _authenticationRepository.logout();
  }
}
