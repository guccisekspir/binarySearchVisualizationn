import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int count = 0;
  CounterBloc() : super(CounterInitial()) {
    on<CounterEvent>((event, emit) {
      if (event is CounterIncrement) {
        count++;
        emit(CounterChanged(count));
      } else if (event is CounterDecrement) {
        count--;
        emit(CounterChanged(count));
      }
    });
  }
}
