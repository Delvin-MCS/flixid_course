import 'package:flixid_course/domain/usecases/logout/logout.dart';
import 'package:flixid_course/presentation/providers/repositories/authenticaion_repository/authentication_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) =>
    Logout(authencitation: ref.watch(authenticationRepositoryProvider));
