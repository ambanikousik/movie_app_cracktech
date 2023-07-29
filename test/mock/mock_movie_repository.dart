import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/option.dart';
import 'package:movie_app_cracktech/domain/failure.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';
import 'package:movie_app_cracktech/domain/movie.dart';
import 'package:movie_app_cracktech/domain/movies_response.dart';

import 'mock_data.dart';

class MockMovieRepository extends IMovieRepo {
  final hasInternetAccess = true;
  @override
  Option<MoviesResponse> tempMoviesResponse = const None();

  @override
  Future<Option<Failure>> cacheMoviesAndGenres(
      MoviesResponse moviesResponse) async {
    tempMoviesResponse = Some(moviesResponse);

    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    return const None();
  }

  @override
  Future<Either<Failure, MoviesResponse>> getCachedMoviesAndGenres() async {
    const genres = MockData.genres;
    final movies = List<Movie>.from(
        MockData.moviesMap.map((element) => Movie.fromMap(element))).lock;
    final moviesResponse = MoviesResponse(genres: genres, movies: movies);
    await Future.delayed(const Duration(seconds: 1));
    return Right(moviesResponse);
  }

  @override
  Future<Either<Failure, IList<String>>> getGenres() async {
    if (hasInternetAccess) {
      return getMoviesAndGenresFromApi()
          .then((value) => value.fold((l) => Left(l), (r) => Right(r.genres)));
    } else {
      return getCachedMoviesAndGenres()
          .then((value) => value.fold((l) => Left(l), (r) => Right(r.genres)));
    }
  }

  @override
  Future<Either<Failure, IList<Movie>>> getMovies() {
    if (hasInternetAccess) {
      return getMoviesAndGenresFromApi()
          .then((value) => value.fold((l) => Left(l), (r) => Right(r.movies)));
    } else {
      return getCachedMoviesAndGenres()
          .then((value) => value.fold((l) => Left(l), (r) => Right(r.movies)));
    }
  }

  @override
  Future<Either<Failure, MoviesResponse>> getMoviesAndGenresFromApi() async {
    const genres = MockData.genres;
    final movies = List<Movie>.from(
        MockData.moviesMap.map((element) => Movie.fromMap(element))).lock;
    final moviesResponse = MoviesResponse(genres: genres, movies: movies);
    await cacheMoviesAndGenres(moviesResponse);
    await Future.delayed(const Duration(seconds: 1));
    return Right(moviesResponse);
  }

  @override
  Future<Either<Failure, IList<Movie>>> getMoviesByGenre(String genre) {
    return getMovies().then((value) => value.fold(
        (l) => Left(l),
        (r) => Right(
            r.where((element) => element.genres.contains(genre)).toIList())));
  }
}
