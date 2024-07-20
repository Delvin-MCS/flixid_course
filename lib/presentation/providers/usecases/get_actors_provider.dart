import 'package:flixid_course/domain/usecases/get_actors/get_actors.dart';
import 'package:flixid_course/presentation/providers/repositories/movie_repository/movie_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_actors_provider.g.dart';

@riverpod
GetActors getActors(GetActorsRef ref) =>
    GetActors(movieRepository: ref.watch(movieRepositoryProvider));
