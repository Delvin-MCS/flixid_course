import 'package:flixid_course/data/repositories/movie_repository.dart';
import 'package:flixid_course/domain/entities/actor.dart';
import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/usecases/get_actors/get_actors_params.dart';
import 'package:flixid_course/domain/usecases/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorParams> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorParams params) async {
    var actorListResult = await _movieRepository.getActors(id: params.movieId);

    return switch (actorListResult) {
      Success(value: final actorList) => Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
