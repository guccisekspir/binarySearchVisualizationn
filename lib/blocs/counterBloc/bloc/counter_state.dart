part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterChanged extends CounterState {
  final int counter;

  CounterChanged(this.counter);
}
