part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class NextWordRequested extends TimerEvent {
  const NextWordRequested();
}

class DurationIncremented extends TimerEvent {
  final int incrementedValue;
  const DurationIncremented({this.incrementedValue = 1});
}

class DurationDecremented extends TimerEvent {
  final int decrementedValue;
  const DurationDecremented({this.decrementedValue = 1});
}

class RandomRequested extends TimerEvent {
  const RandomRequested();
}

class RestartRequested extends TimerEvent {
  const RestartRequested();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}
