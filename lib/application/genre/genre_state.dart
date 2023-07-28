import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';

import 'package:movie_app_cracktech/domain/failure.dart';

class GenreState extends Equatable {
  final IList<String> genres;
  final bool loading;
  final Option<Failure> failure;
  const GenreState(
      {required this.genres, required this.loading, required this.failure});
  factory GenreState.init() =>
      const GenreState(genres: IListConst([]), loading: false, failure: None());
  @override
  List<Object> get props => [genres, loading, failure];

  GenreState copyWith({
    IList<String>? genres,
    bool? loading,
    Option<Failure>? failure,
  }) {
    return GenreState(
      genres: genres ?? this.genres,
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
    );
  }
}
