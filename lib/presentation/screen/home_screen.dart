import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/constants/enums.dart';
import 'package:flutter_bloc_example/logic/cubit/counter/counter_cubit.dart';
import 'package:flutter_bloc_example/logic/cubit/internet/internet_connected.dart';
import 'package:flutter_bloc_example/logic/cubit/internet/internet_cubit.dart';
import 'package:flutter_bloc_example/logic/cubit/internet/internet_disconnected.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetConnected) {
                  return Text(state.connectionType.name.toUpperCase());
                } else if (state is InternetDisconnected) {
                  return const Text('Disconnected');
                }
                return const Text('Loading');
              }),
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
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                    heroTag: 'decremented',
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
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
        ),
      ),
    );
  }
}
