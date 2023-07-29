import 'package:bloc_test/bloc_test.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_cracktech/application/genre/genre_bloc.dart';
import 'package:movie_app_cracktech/application/genre/genre_event.dart';
import 'package:movie_app_cracktech/application/genre/genre_state.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';

import 'mock/mock_movie_repository.dart';

void main() {
  group('GenreBloc', () {
    late GenreBloc genreBloc;
    late IMovieRepo movieRepo;

    setUp(() {
      movieRepo = MockMovieRepository();
      genreBloc = GenreBloc(movieRepo);
    });

    blocTest(
      'call load data event and get loading state and genre loaded state',
      build: () => genreBloc,
      act: (bloc) => bloc.add(LoadGenreEvent()),
      wait: const Duration(seconds: 2),
      expect: () {
        return [
          GenreState.init().copyWith(loading: true),
          genreBloc.state.copyWith(
              genres: movieRepo.tempMoviesResponse
                  .fold(() => IList<String>(const []), (a) => a.genres),
              loading: false),
        ];
      },
    );
  });
}
