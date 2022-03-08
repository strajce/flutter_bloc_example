import 'package:flutter_bloc_example/constants/enums.dart';
import 'package:flutter_bloc_example/logic/cubit/internet/internet_cubit.dart';

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  const InternetConnected({
    required this.connectionType,
  });
}
