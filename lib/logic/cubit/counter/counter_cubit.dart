import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit()
      : super(
          const CounterState(
            counterValue: 0,
          ),
        );

  // void monitorInternetCubit() {
  //   internetStreamSubscription = internetCubit.stream.listen(
  //     (internetState) {
  //       if (internetState is InternetConnected &&
  //           internetState.connectionType == ConnectionType.wifi) {
  //         increment();
  //       } else if (internetState is InternetConnected &&
  //           internetState.connectionType == ConnectionType.mobile) {
  //         decrement();
  //       }
  //     },
  //   );
  // }

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

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }
}
