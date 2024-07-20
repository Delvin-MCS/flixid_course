import 'package:flixid_course/domain/usecases/register/register.dart';
import 'package:flixid_course/presentation/providers/repositories/authenticaion_repository/authentication_repository_provider.dart';
import 'package:flixid_course/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider));
