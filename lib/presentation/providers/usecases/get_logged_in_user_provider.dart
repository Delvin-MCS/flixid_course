import 'package:flixid_course/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:flixid_course/presentation/providers/repositories/authenticaion_repository/authentication_repository_provider.dart';
import 'package:flixid_course/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider));
