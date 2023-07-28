import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movie_app_cracktech/application/genre/genre_bloc.dart';
import 'package:movie_app_cracktech/application/genre/genre_event.dart';
import 'package:movie_app_cracktech/application/movie/movies_bloc.dart';
import 'package:movie_app_cracktech/domain/i_movie_repo.dart';
import 'package:movie_app_cracktech/infrastructure/movie_repo.dart';
import 'package:movie_app_cracktech/presentation/home_page.dart';

import '../application/connectivity/connectivity_cubit.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, InternetStatus>(
        builder: (context, status) {
      return RepositoryProvider<IMovieRepo>(
          create: (context) => MovieRepo(
                hiveBox: Hive.box('movieBox'),
                httpClient: http.Client(),
              ),
          child: MultiBlocProvider(providers: [
            BlocProvider<GenreBloc>(
              create: (context) =>
                  GenreBloc(RepositoryProvider.of<IMovieRepo>(context))
                    ..add(LoadGenreEvent()),
            ),
            BlocProvider<MovieBloc>(
                create: (context) => MovieBloc(
                    movieRepo: RepositoryProvider.of<IMovieRepo>(context)))
          ], child: const HomePage()));
    });
  }
}
