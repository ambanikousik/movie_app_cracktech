import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movie_app_cracktech/domain/failure.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';
import 'package:movie_app_cracktech/domain/movie.dart';
import 'package:movie_app_cracktech/domain/movies_response.dart';
import 'package:http/http.dart';

class MovieRepo extends IMovieRepo {
  final Box hiveBox;
  final Client httpClient;

  MovieRepo(
      {required this.hiveBox,
      required this.httpClient,
      this.tempMoviesResponse = const None()});

  @override
  Future<Option<Failure>> cacheMoviesAndGenres(
      MoviesResponse moviesResponse) async {
    try {
      await hiveBox.put('movies',
          moviesResponse.movies.map((element) => element.toMap()).toList());
      await hiveBox.put('genres', moviesResponse.genres.unlock);
      return Future.value(const None());
    } catch (e) {
      return Future.value(Some(
          Failure(message: e.toString(), context: 'cacheMoviesAndGenres')));
    }
  }

  @override
  Future<Either<Failure, MoviesResponse>> getCachedMoviesAndGenres() {
    try {
      final List moviesMap = hiveBox.get('movies', defaultValue: []);
      final movies = moviesMap
          .map((element) => Movie.fromMap(element as Map<String, dynamic>))
          .toList();
      final List<String> genres =
          List<String>.from(hiveBox.get('genres', defaultValue: []));
      if (movies.isNotEmpty && genres.isNotEmpty) {
        return Future.value(Right(MoviesResponse(
          movies: movies.lock,
          genres: genres.lock,
        )));
      } else {
        return Future.value(const Left(Failure(
            message: 'No cached movies and genres',
            context: 'getCachedMoviesAndGenres')));
      }
    } catch (e) {
      return Future.value(Left(
          Failure(message: e.toString(), context: 'getCachedMoviesAndGenres')));
    }
  }

  @override
  Future<Either<Failure, IList<String>>> getGenres() async {
    final hasInternetAccess = await InternetConnection().hasInternetAccess;
    if (hasInternetAccess) {
      return getMoviesAndGenresFromApi()
          .then((value) => value.fold((l) => Left(l), (r) => Right(r.genres)));
    } else {
      return getCachedMoviesAndGenres()
          .then((value) => value.fold((l) => Left(l), (r) => Right(r.genres)));
    }
  }

  @override
  Future<Either<Failure, IList<Movie>>> getMovies() async {
    final hasInternetAccess = await InternetConnection().hasInternetAccess;

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
    return tempMoviesResponse.fold(() async {
      try {
        final response = await httpClient.get(Uri.parse(
            'https://raw.githubusercontent.com/erik-sytnyk/movies-list/master/db.json'));
        if (response.statusCode == 200) {
          final moviesResponse = MoviesResponse.fromJson(response.body);
          final chachingResult = await cacheMoviesAndGenres(moviesResponse);
          return chachingResult.fold(
              () => Right(moviesResponse), (t) => Left(t));
        } else {
          return Left(Failure(
              message:
                  'Error getting movies from api\nstatus code:${response.statusCode}\nresponse: ${response.body}}',
              context: 'getMoviesAndGenresFromApi'));
        }
      } catch (e) {
        return Left(Failure(
            message: e.toString(), context: 'getMoviesAndGenresFromApi'));
      }
    }, (t) => right(t));
  }

  @override
  Future<Either<Failure, IList<Movie>>> getMoviesByGenre(String genre) {
    return getMovies().then((value) => value.fold(
        (l) => Left(l),
        (r) => Right(
            r.where((element) => element.genres.contains(genre)).toIList())));
  }

  @override
  Option<MoviesResponse> tempMoviesResponse;
}
