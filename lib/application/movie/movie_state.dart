import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';

import 'package:movie_app_cracktech/domain/failure.dart';
import 'package:movie_app_cracktech/domain/movie.dart';

class MovieState extends Equatable {
  final String genre;
  final IList<Movie> movies;
  final bool loading;
  final Option<Failure> failure;
  const MovieState(
      {required this.movies,
      required this.loading,
      required this.failure,
      required this.genre});
  factory MovieState.init() => const MovieState(
      movies: IListConst([]), loading: false, failure: None(), genre: '');
  @override
  List<Object> get props => [movies, loading, failure];

  MovieState copyWith({
    IList<Movie>? movies,
    bool? loading,
    Option<Failure>? failure,
    String? genre,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      genre: genre ?? this.genre,
    );
  }
}
