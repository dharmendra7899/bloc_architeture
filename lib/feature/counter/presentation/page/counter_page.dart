import 'package:counter_demo_bloc/feature/counter/presentation/bloc/counter_bloc.dart';
import 'package:counter_demo_bloc/res/constants/texts.dart';
import 'package:counter_demo_bloc/res/widgets/context_extension.dart';
import 'package:counter_demo_bloc/theme/colors.dart';
import 'package:counter_demo_bloc/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 12,
        title: Text(
          texts.appName,
          style: context.textTheme.bodyLarge?.copyWith(
            color: appColors.appWhite,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        actions: [
          TextButton(
            onPressed: () {
              // normal route
              // Navigator.pushNamed(context, RouteNames.login);
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.login,
                (route) => false,
              );
            },
            child: Text(
              "Login Page",
              style: context.textTheme.bodyMedium?.copyWith(
                color: appColors.appWhite,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            switch (state.status) {
              case CounterStatus.isSuccess:
                return Text(
                  '${state.counter}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                    fontFamily: 'Roboto',
                  ),
                );
              case CounterStatus.isLoading:
                return const CircularProgressIndicator.adaptive();
              case CounterStatus.isFailed:
                return const Text(
                  'Something went wrong, Please try again letter',
                );
              default:
                return const Text(
                  '0',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    fontFamily: 'Roboto',
                  ),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed:
            () => context.read<CounterBloc>().add(const IncrementEvent()),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
