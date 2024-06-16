import 'package:flixid_course/data/firebase/firebase_user.dart';
import 'package:flixid_course/data/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => FirebaseUser();
