import 'package:flixid_course/domain/usecases/get_movie_detail/get_movie_detail.dart';
import 'package:flixid_course/presentation/providers/repositories/movie_repository/movie_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movie_detail_provider.g.dart';

@riverpod
GetMovieDetail getMovieDetail(GetMovieDetailRef ref) =>
    GetMovieDetail(movieRepository: ref.watch(movieRepositoryProvider));
