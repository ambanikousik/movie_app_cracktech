import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityCubit extends Cubit<InternetStatus> {
  final InternetConnection internetConnection;
  ConnectivityCubit(this.internetConnection)
      : super(InternetStatus.disconnected);
  StreamSubscription<InternetStatus>? _subscription;

  void listenConnectivity() {
    _subscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      emit(status);
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
