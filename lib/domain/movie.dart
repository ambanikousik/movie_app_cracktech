import 'dart:convert';

import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String year;
  final String runtime;
  final List<String> genres;
  final String director;
  final String actors;
  final String plot;
  final String posterUrl;
  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.runtime,
    required this.genres,
    required this.director,
    required this.actors,
    required this.plot,
    required this.posterUrl,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? year,
    String? runtime,
    List<String>? genres,
    String? director,
    String? actors,
    String? plot,
    String? posterUrl,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      runtime: runtime ?? this.runtime,
      genres: genres ?? this.genres,
      director: director ?? this.director,
      actors: actors ?? this.actors,
      plot: plot ?? this.plot,
      posterUrl: posterUrl ?? this.posterUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'runtime': runtime,
      'genres': genres,
      'director': director,
      'actors': actors,
      'plot': plot,
      'posterUrl': posterUrl,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      year: map['year'] ?? '',
      runtime: map['runtime'] ?? '',
      genres: List<String>.from(map['genres']),
      director: map['director'] ?? '',
      actors: map['actors'] ?? '',
      plot: map['plot'] ?? '',
      posterUrl: map['posterUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, year: $year, runtime: $runtime, genres: $genres, director: $director, actors: $actors, plot: $plot, posterUrl: $posterUrl)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      year,
      runtime,
      genres,
      director,
      actors,
      plot,
      posterUrl,
    ];
  }
}
