part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent();
}
