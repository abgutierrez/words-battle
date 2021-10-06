part of 'timer_bloc.dart';

enum TimerStatus { pending, running, completed, paused }

class TimerState {
  final int remaining;
  final int duration;
  final Word? word;
  final Word? nextWord;
  final bool nextCompleted;
  final TimerStatus status;
  const TimerState(
      {this.remaining = 0,
      this.duration = 5,
      this.word,
      this.nextWord,
      this.nextCompleted = false,
      this.status = TimerStatus.pending});

  TimerState copyWith({
    int? remaining,
    int? duration,
    Word? word,
    Word? nextWord,
    bool? nextCompleted,
    TimerStatus? status,
  }) =>
      TimerState(
        remaining: remaining ?? this.remaining,
        duration: duration ?? this.duration,
        nextWord: nextWord ?? this.nextWord,
        nextCompleted: nextCompleted ?? this.nextCompleted,
        word: word ?? this.word,
        status: status ?? this.status,
      );

  @override
  String toString() =>
      'TimerState { remaining: $remaining,duration: $duration, word: ${word?.value}, nextWord: ${nextWord?.value}, nextCompleted: $nextCompleted, isPaused: $status, }';
}
