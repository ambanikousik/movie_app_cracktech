import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app_cracktech/application/genre/genre_state.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';

class GenreCubit extends Cubit<GenreState> {
  final IMovieRepo movieRepo;
  GenreCubit(this.movieRepo) : super(GenreState.init());

  Future<void> loadData() async {
    emit(state.copyWith(loading: true, failure: const None()));
    final failureOrGenres = await movieRepo.getGenres();
    failureOrGenres.fold(
        (failure) =>
            emit(state.copyWith(failure: Some(failure), loading: false)),
        (genres) => emit(
              state.copyWith(genres: genres, loading: false),
            ));
  }
}
