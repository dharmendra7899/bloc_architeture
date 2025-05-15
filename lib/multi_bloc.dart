import 'package:counter_demo_bloc/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:counter_demo_bloc/feature/counter/presentation/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;

  const MultiBlocWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (_) => serviceLocator<CounterBloc>()),
        BlocProvider<AuthBloc>(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: child,
    );
  }
}
