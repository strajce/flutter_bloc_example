import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_example/constants/enums.dart';
import 'package:flutter_bloc_example/logic/internet/internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;
  CounterCubit({
    required this.internetCubit,
  }) : super(
          const CounterState(
            counterValue: 0,
          ),
        ) {
    monitorInternetCubit();
  }

  void monitorInternetCubit() {
    internetStreamSubscription = internetCubit.stream.listen(
      (internetState) {
        if (internetState is InternetConnected &&
            internetState.connectionType == ConnectionType.wifi) {
          increment();
        } else if (internetState is InternetConnected &&
            internetState.connectionType == ConnectionType.mobile) {
          decrement();
        }
      },
    );
  }

  void increment() => emit(
        CounterState(
          counterValue: state.counterValue + 1,
          wasIncremented: true,
        ),
      );

  void decrement() => emit(
        CounterState(
          counterValue: state.counterValue - 1,
          wasIncremented: false,
        ),
      );
}
