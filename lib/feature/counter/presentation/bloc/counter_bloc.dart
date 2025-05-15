import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<IncrementEvent>(_onCounterIncremented);
  }

  Future<void> _onCounterIncremented(
    IncrementEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(status: CounterStatus.isLoading));
    await Future.delayed(const Duration(seconds: 1));
    emit(
      state.copyWith(
        status: CounterStatus.isSuccess,
        counter: state.counter + 1,
      ),
    );
  }
}
