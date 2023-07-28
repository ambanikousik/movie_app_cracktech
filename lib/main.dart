import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movie_app_cracktech/presentation/root.dart';
import 'package:path/path.dart' as path_helper;
import 'package:path_provider/path_provider.dart';

import 'application/connectivity/connectivity_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(path_helper.join(appDir.path, 'hive'));
  await Hive.openBox('movieBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App CrackTech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (context) =>
              ConnectivityCubit(InternetConnection())..listenConnectivity(),
          child: const Root()),
    );
  }
}
