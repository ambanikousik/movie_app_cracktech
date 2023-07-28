import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:movie_app_cracktech/domain/movie.dart';

class MoviesResponse extends Equatable {
  final IList<Movie> movies;
  final IList<String> genres;
  const MoviesResponse({
    required this.movies,
    required this.genres,
  });

  MoviesResponse copyWith({
    IList<Movie>? movies,
    IList<String>? genres,
  }) {
    return MoviesResponse(
      movies: movies ?? this.movies,
      genres: genres ?? this.genres,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movies': movies.map((x) => x.toMap()).toList(),
      'genres': genres,
    };
  }

  factory MoviesResponse.fromMap(Map<String, dynamic> map) {
    return MoviesResponse(
      movies:
          List<Movie>.from(map['movies']?.map((x) => Movie.fromMap(x))).lock,
      genres: List<String>.from(map['genres']).lock,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviesResponse.fromJson(String source) =>
      MoviesResponse.fromMap(json.decode(source));

  @override
  String toString() => 'MoviesResponse(movies: $movies, genres: $genres)';

  @override
  List<Object> get props => [movies, genres];
}
