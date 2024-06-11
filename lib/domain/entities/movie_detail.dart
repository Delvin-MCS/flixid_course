import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';

@Freezed(fromJson: false, toJson: false)
class MovieDetail with _$MovieDetail {
  factory MovieDetail({
    required int id,
    required String title,
    String? posterPath,
    required String overview,
    String? backdropPath,
    required int runtime,
    required double voteAverage,
    required List<String> genres,
  }) = _MovieDetail;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      backdropPath: json['backdrop_path'],
      runtime: json['runtime'],
      voteAverage: json['vote_average'].toDouble(),
      genres: List<String>.from(json['genres'].map((e) => e['name'])));
}
