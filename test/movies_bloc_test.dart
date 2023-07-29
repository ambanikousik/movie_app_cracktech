import 'package:bloc_test/bloc_test.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_cracktech/application/movie/movie_state.dart';
import 'package:movie_app_cracktech/application/movie/movies_bloc.dart';
import 'package:movie_app_cracktech/application/movie/movies_event.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';
import 'package:movie_app_cracktech/domain/movie.dart';

import 'mock/mock_movie_repository.dart';

void main() {
  group('MovieBloc', () {
    late MovieBloc movieBloc;
    late IMovieRepo movieRepo;

    setUp(() {
      movieRepo = MockMovieRepository();
      movieBloc = MovieBloc(movieRepo: movieRepo);
    });

    blocTest(
      'call load data event and get loading state and movies loaded state',
      build: () => movieBloc,
      act: (bloc) => bloc.add(const LoadMoviesEvent(genre: 'Crime')),
      wait: const Duration(seconds: 2),
      expect: () {
        final movies = movieRepo.tempMoviesResponse.fold(
            () => IList<Movie>(const []),
            (a) => a.movies
                .where((element) => element.genres.contains('Crime'))
                .toIList());
        return [
          MovieState.init().copyWith(loading: true),
          movieBloc.state.copyWith(movies: movies, loading: false),
        ];
      },
    );
  });
}
