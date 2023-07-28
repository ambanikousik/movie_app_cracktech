import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_cracktech/application/genre/genre_bloc.dart';
import 'package:movie_app_cracktech/application/genre/genre_state.dart';
import 'package:movie_app_cracktech/application/movie/movies_event.dart';
import 'package:movie_app_cracktech/application/movie/movies_bloc.dart';
import 'package:movie_app_cracktech/presentation/widget/internet_connection_status_widget.dart';
import 'package:movie_app_cracktech/presentation/widget/movie_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenreBloc, GenreState>(
        listenWhen: (previous, current) =>
            previous.loading != current.loading && !current.loading,
        listener: (context, state) {
          if (state.failure.isNone() && state.genres.isNotEmpty) {
            context
                .read<MovieBloc>()
                .add(LoadMoviesEvent(genre: state.genres.first));
          }
          state.failure.fold(
              () => null,
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
                      )));
        },
        builder: (context, state) {
          return DefaultTabController(
            length: state.genres.length,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  leading: const Icon(Icons.menu),
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  title: const Text('MovieOnline'),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            'https://i.pravatar.cc/300'),
                      ),
                    )
                  ],
                  bottom: TabBar(
                    indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(50), // Creates border
                        color: Colors.black),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(left: 10),
                    onTap: (value) {
                      context
                          .read<MovieBloc>()
                          .add(LoadMoviesEvent(genre: state.genres[value]));
                    },
                    isScrollable: true,
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                    tabs: state.genres
                        .map((e) => Tab(
                              child: Container(
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border:
                                          Border.all(color: Colors.black26)),
                                  child: Text(e)),
                            ))
                        .toList(),
                  ),
                ),
                body: state.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          const InternetConnectionStatusWidget(),
                          if (state.genres.isEmpty)
                            const Center(
                              child: Text('No genre available'),
                            )
                          else
                            const Expanded(
                              child: Column(
                                children: [Expanded(child: MovieListView())],
                              ),
                            ),
                        ],
                      )),
          );
        });
  }
}
