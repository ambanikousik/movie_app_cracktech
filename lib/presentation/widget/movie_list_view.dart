import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_cracktech/application/movie/movie_cubit.dart';
import 'package:movie_app_cracktech/application/movie/movie_state.dart';
import 'package:movie_app_cracktech/presentation/widget/movie_list_tile.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) => state.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state.movies.isEmpty
              ? Center(
                  child: Text('No ${state.genre} movies available'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${state.movies.length} ${state.genre} movies available'),
                    Expanded(
                      child: ListView.builder(
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
