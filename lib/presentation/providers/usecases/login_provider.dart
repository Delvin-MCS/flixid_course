import 'package:flixid_course/domain/usecases/login/login.dart';
import 'package:flixid_course/presentation/providers/repositories/authenticaion_repository/authentication_repository_provider.dart';
import 'package:flixid_course/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider));
