import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app_cracktech/application/genre/genre_event.dart';
import 'package:movie_app_cracktech/application/genre/genre_state.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';

class GenreBloc extends Bloc<LoadGenreEvent, GenreState> {
  final IMovieRepo movieRepo;
  GenreBloc(this.movieRepo) : super(GenreState.init()) {
    on<LoadGenreEvent>((event, emit) async {
      emit(state.copyWith(loading: true, failure: const None()));
      final failureOrGenres = await movieRepo.getGenres();
      failureOrGenres.fold(
          (failure) =>
              emit(state.copyWith(failure: Some(failure), loading: false)),
          (genres) => emit(
                state.copyWith(genres: genres, loading: false),
              ));
    });
  }
}
