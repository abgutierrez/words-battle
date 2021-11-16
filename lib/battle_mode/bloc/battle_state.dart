part of 'battle_bloc.dart';

enum BattleStatus { pending, running, completed, paused }

class BattleState extends Equatable {
  final BattleStatus status;

  const BattleState({
    this.status = BattleStatus.pending,
  });

  @override
  List<Object> get props => [];

  BattleState copyWith({
    BattleStatus? status,
  }) =>
      BattleState(
        status: status ?? this.status,
      );

  @override
  String toString() => 'TimerState {  status: $status }';
}

class BattleLoading extends BattleState {
  const BattleLoading() : super();
}

class BattleLoaded extends BattleState {
  const BattleLoaded(
    this.randomWord,
    this.nextWord,
    TimerBloc timerBloc,
  ) : super();
  final Word randomWord;
  final Word nextWord;
}
