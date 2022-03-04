import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_example/constants/enums.dart';
import 'package:flutter_bloc_example/logic/internet/internet_connected.dart';
import 'package:flutter_bloc_example/logic/internet/internet_disconnected.dart';
import 'package:flutter_bloc_example/logic/internet/internet_loading.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({
    required this.connectivity,
  }) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        switch (connectivityResult) {
          case ConnectivityResult.wifi:
            {
              emitInternetConnected(ConnectionType.wifi);
            }
            break;
          case ConnectivityResult.bluetooth:
            break;
          case ConnectivityResult.ethernet:
            break;
          case ConnectivityResult.mobile:
            {
              emitInternetConnected(ConnectionType.mobile);
            }
            break;
          case ConnectivityResult.none:
            {
              emitInternetDisconnected(ConnectionType.disconnected);
            }
            break;
        }
        // if (connectivityResult == ConnectivityResult.wifi) {
        //   emitInternetConnected(ConnectionType.Wifi);
        // } else if (connectivityResult == ConnectivityResult.mobile) {
        //   emitInternetConnected(ConnectionType.Mobile);
        // } else if (connectivityResult == ConnectivityResult.none) {
        //   emitInternetDisconnected();
        // }
      },
    );
  }

  // void wifi() => emit(
  //       const InternetState(displayConnectionType: 'Wifi');
  //     );

  void emitInternetConnected(ConnectionType _connectionType) {
    emit(InternetConnected(
      connectionType: _connectionType,
    ));
  }

  void emitInternetDisconnected(ConnectionType _connectionType) => emit(
        InternetDisconnected(),
      );

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
