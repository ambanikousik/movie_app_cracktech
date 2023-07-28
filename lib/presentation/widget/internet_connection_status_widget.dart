import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movie_app_cracktech/application/connectivity/connectivity_cubit.dart';
import 'package:movie_app_cracktech/application/genre/genre_bloc.dart';
import 'package:movie_app_cracktech/application/genre/genre_event.dart';

class InternetConnectionStatusWidget extends StatelessWidget {
  const InternetConnectionStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, InternetStatus>(
      listener: (context, state) =>
          context.read<GenreBloc>().add(LoadGenreEvent()),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => state == InternetStatus.connected
          ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: const Text(
                    'You are online',
                    style: TextStyle(color: Colors.white),
                  ))
              .animate()
              .slideY(
                  delay: const Duration(
                    seconds: 2,
                  ),
                  end: -1)
              .visibility(
                  delay: const Duration(
                    seconds: 2,
                  ),
                  maintain: false,
                  end: false)
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(4),
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text(
                'You are offline, serving data from cache',
                style: TextStyle(color: Colors.white),
              )).animate().slideY(end: 0, begin: -1),
    );
  }
}
