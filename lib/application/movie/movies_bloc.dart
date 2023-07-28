import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app_cracktech/application/movie/movies_event.dart';
import 'package:movie_app_cracktech/application/movie/movie_state.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';

class MovieBloc extends Bloc<LoadMoviesEvent, MovieState> {
  final IMovieRepo movieRepo;
  MovieBloc({
    required this.movieRepo,
  }) : super(MovieState.init()) {
    on<LoadMoviesEvent>(
      (event, emit) async {
        emit(state.copyWith(loading: true, failure: const None()));
        final failureOrMovies = await movieRepo.getMoviesByGenre(event.genre);
        failureOrMovies.fold(
            (failure) =>
                emit(state.copyWith(failure: Some(failure), loading: false)),
            (movies) => emit(
                  state.copyWith(
                      movies: movies, loading: false, genre: event.genre),
                ));
      },
    );
  }
}
