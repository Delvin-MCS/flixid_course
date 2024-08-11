import 'package:dio/dio.dart';
import 'package:flixid_course/data/repositories/movie_repository.dart';
import 'package:flixid_course/domain/entities/actor.dart';
import 'package:flixid_course/domain/entities/movie.dart';
import 'package:flixid_course/domain/entities/movie_detail.dart';
import 'package:flixid_course/domain/entities/result.dart';

class TmdbMovie implements MovieRepository {
  final Dio? _dio;
  final String _accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiZGM0MWViOWI2NjFmNjdhMjU2OGUxNTExZGIwYWE5MiIsIm5iZiI6MTcyMjcwMTk2Ni4zNTIzOTMsInN1YiI6IjY1ZTI4OGIwMjc4ZDhhMDE4NWJkNzQyNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9CN5tq5OJfwma59K6QOdGlgHCiiMrLeu6EGzd90WaX8";
  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accessToken',
    'accept': 'application/json'
  });

  TmdbMovie({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id/credits',
          options: _options);

      final results = List<Map<String, dynamic>>.from(response.data['cast']);

      return Result.success(results.map((e) => Actor.fromJson(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id?language=en-US',
          options: _options);

      return Result.success(MovieDetail.fromJson(response.data));
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async {
    return _getMovies(_MovieCategory.nowPlaying.toString(), page: page);
  }

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async {
    return _getMovies(_MovieCategory.upcoming.toString(), page: page);
  }

  Future<Result<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      final response = await _dio?.get(
          'https://api.themoviedb.org/3/movie/$category',
          options: _options);

      final results =
          List<Map<String, dynamic>>.from(response?.data['results']);

      return Result.success(results.map((e) => Movie.fromJson(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _inString;

  const _MovieCategory(String inString) : _inString = inString;

  @override
  String toString() => _inString;
}
