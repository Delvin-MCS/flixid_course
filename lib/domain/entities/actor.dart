import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor.freezed.dart';

@Freezed(fromJson: false, toJson: false)
class Actor with _$Actor {
  factory Actor({
    required String name,
    String? profilePath,
  }) = _Actor;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        name: json['name'],
        profilePath: json['profile_path'],
      );
}
