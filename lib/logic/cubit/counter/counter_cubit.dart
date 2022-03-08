import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
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
}
