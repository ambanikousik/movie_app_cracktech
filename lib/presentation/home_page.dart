import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_cracktech/application/genre/genre_cubit.dart';
import 'package:movie_app_cracktech/application/genre/genre_state.dart';
import 'package:movie_app_cracktech/application/movie/movie_cubit.dart';
import 'package:movie_app_cracktech/presentation/widget/internet_connection_status_widget.dart';
import 'package:movie_app_cracktech/presentation/widget/movie_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenreCubit, GenreState>(
        listenWhen: (previous, current) =>
            previous.loading != current.loading && !current.loading,
        listener: (context, state) {
          if (state.failure.isNone() && state.genres.isNotEmpty) {
            context.read<MovieCubit>().loadData(state.genres.first);
          }
          state.failure.fold(
              () => null,
              (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: ListTile(
                    tileColor: Colors.white,
                    subtitleTextStyle: const TextStyle(color: Colors.red),
                    title: Text('Error: ${failure.context}'),
                    subtitle: Text(failure.message),
                  ))));
        },
        builder: (context, state) {
          return Scaffold(
              body: state.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        const InternetConnectionStatusWidget(),
                        state.genres.isEmpty
                            ? const Center(
                                child: Text('No genre available'),
                              )
                            : Expanded(
                                child: DefaultTabController(
                                  length: state.genres.length,
                                  child: Column(
                                    children: [
                                      TabBar(
                                          onTap: (value) {
                                            context
                                                .read<MovieCubit>()
                                                .loadData(state.genres[value]);
                                          },
                                          isScrollable: true,
                                          tabs: state.genres
                                              .map((e) => Tab(
                                                    text: e,
                                                  ))
                                              .toList()),
                                      const Expanded(child: MovieListView())
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ));
        });
  }
}
