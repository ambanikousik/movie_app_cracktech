import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_cracktech/application/movie/movies_bloc.dart';
import 'package:movie_app_cracktech/application/movie/movie_state.dart';
import 'package:movie_app_cracktech/presentation/widget/movie_list_tile.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
      listenWhen: (previous, current) => previous.failure != current.failure,
      listener: (context, state) => state.failure.fold(
        () {},
        (failure) => showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Error'),
            content: Text('context: ${failure.context},\n'
                'error: ${failure.message}'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
          ),
        ),
      ),
      builder: (context, state) => state.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state.movies.isEmpty
              ? Center(
                  child: Text('No ${state.genre} movies available',
                      style: Theme.of(context).textTheme.bodyLarge),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '${state.movies.length} ${state.genre} movies available',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: state.movies.length,
                        itemBuilder: (BuildContext context, int index) =>
                            MovieListTile(movie: state.movies[index]),
                      ),
                    ),
                  ],
                ),
    );
  }
}
