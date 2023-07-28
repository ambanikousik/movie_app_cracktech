import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app_cracktech/domain/failure.dart';
import 'package:movie_app_cracktech/domain/movies_response.dart';

import 'movie.dart';

abstract class IMovieRepo {
  Future<Either<Failure, IList<Movie>>> getMovies();
  Future<Either<Failure, IList<Movie>>> getMoviesByGenre(String genre);
  Future<Either<Failure, IList<String>>> getGenres();
  Future<Either<Failure, MoviesResponse>> getMoviesAndGenresFromApi();
  Future<Option<Failure>> cacheMoviesAndGenres(MoviesResponse moviesResponse);
  Future<Either<Failure, MoviesResponse>> getCachedMoviesAndGenres();

  Option<MoviesResponse> get tempMoviesResponse;
  set tempMoviesResponse(Option<MoviesResponse> value);
}
