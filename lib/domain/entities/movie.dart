import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@Freezed(fromJson: false, toJson: false)
class Movie with _$Movie {
  factory Movie({required int id, required String title, String? posterPath}) =
      _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      id: json['id'], title: json['title'], posterPath: json['poster_path']);
}
