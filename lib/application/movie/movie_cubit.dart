import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app_cracktech/application/movie/movie_state.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';

class MovieCubit extends Cubit<MovieState> {
  final IMovieRepo movieRepo;
  MovieCubit({
    required this.movieRepo,
  }) : super(MovieState.init());

  Future<void> loadData(String genre) async {
    if (genre != state.genre) {
      emit(state.copyWith(loading: true, failure: const None()));
      final failureOrMovies = await movieRepo.getMoviesByGenre(genre);
      failureOrMovies.fold(
          (failure) =>
              emit(state.copyWith(failure: Some(failure), loading: false)),
          (movies) => emit(
                state.copyWith(movies: movies, loading: false, genre: genre),
              ));
    }
  }
}
