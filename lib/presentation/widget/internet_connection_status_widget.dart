import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movie_app_cracktech/application/connectivity/connectivity_cubit.dart';
import 'package:movie_app_cracktech/application/genre/genre_cubit.dart';

class InternetConnectionStatusWidget extends StatelessWidget {
  const InternetConnectionStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, InternetStatus>(
      listener: (context, state) => context.read<GenreCubit>().loadData(),
      builder: (context, state) => Text(state.name),
    );
  }
}
