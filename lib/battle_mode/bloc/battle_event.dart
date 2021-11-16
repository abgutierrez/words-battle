part of 'battle_bloc.dart';

abstract class BattleEvent extends Equatable {
  const BattleEvent();

  @override
  List<Object> get props => [];
}

class BattleInitialized extends BattleEvent {}

class BattleStarted extends BattleEvent {}
