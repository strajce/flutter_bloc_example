import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/constants/enums.dart';
import 'package:flutter_bloc_example/logic/counter/counter_cubit.dart';
import 'package:flutter_bloc_example/logic/internet/internet_cubit.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return const Text(
                    'Wifi',
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return const Text(
                    'Mobile',
                  );
                } else if (state is InternetDisconnected) {
                  return const Text(
                    'Disconnected',
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text(
                  //       'Incremented',
                  //     ),
                  //   ),
                  // );
                  log('Incremented');
                } else if (state.wasIncremented == false) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text(
                  //       'Decremented',
                  //     ),
                  //   ),
                  // );
                  log('Decremented');
                }
              },
              builder: (context, state) {
                return SizedBox(
                  child: Column(
                    children: [
                      Text(
                        state.counterValue.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(context)
                                  .decrement();
                            },
                            tooltip: 'Decrement',
                            child: const Icon(Icons.remove),
                            heroTag: 'decremented',
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(context)
                                  .increment();
                            },
                            tooltip: 'Increment',
                            child: const Icon(Icons.add),
                            heroTag: 'incremented',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/second',
                          );
                        },
                        color: Colors.blue,
                        child: const Text(
                          'Go to Second Screen',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/third',
                          );
                        },
                        color: Colors.blue,
                        child: const Text(
                          'Go to Third Screen',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
