import 'package:flixid_course/data/repositories/movie_repository.dart';
import 'package:flixid_course/domain/entities/actor.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/usecases/get_actors/get_actors_param.dart';
import 'package:flixid_course/domain/usecases/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorParam> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorParam params) async {
    var actorListResult = await _movieRepository.getActors(id: params.movieId);

    return switch (actorListResult) {
      Success(value: final actorList) => Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
