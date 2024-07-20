import 'package:flixid_course/domain/entities/actor.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/usecases/get_actors/get_actors.dart';
import 'package:flixid_course/domain/usecases/get_actors/get_actors_param.dart';
import 'package:flixid_course/presentation/providers/usecases/get_actors_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActors = ref.read(getActorsProvider);

  var actorsResult = await getActors(GetActorParam(movieId: movieId));

  return switch (actorsResult) {
    Success(value: final actors) => actors,
    Failed(message: _) => const []
  };
}
