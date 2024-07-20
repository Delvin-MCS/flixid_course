import 'package:flixid_course/data/repositories/movie_repository.dart';
import 'package:flixid_course/data/tmdb/tmdb_movie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_repository_provider.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) => TmdbMovie();
