import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_generator/model/word.dart';
import 'package:words_generator/timer/timer.dart';
import 'package:words_generator/words_repository/words_repository.dart';

part 'battle_event.dart';
part 'battle_state.dart';

class BattleBloc extends Bloc<BattleEvent, BattleState> {
  BattleBloc({
    required TimerBloc timerBloc,
    required WordRepository wordRepository,
  })  : _timerBloc = timerBloc,
        _wordRepository = wordRepository,
        super(BattleState()) {
    on<BattleInitialized>((event, emit) => _initialize(event, emit));
    on<BattleStarted>((event, emit) => _initialize(event, emit));
    on<BattleEvent>((event, emit) => _onStart(event, emit));
  }
  late final Word? randomWord;
  late final Word? nextWord;
  final WordRepository _wordRepository;
  final TimerBloc _timerBloc;

  void _initialize(BattleEvent event, Emitter<BattleState> emit) async {
    await _wordRepository.getWords().then((json) {
      randomWord = json['randomWord'];
      nextWord = json['nextWord'];
    });
    emit(BattleLoading());
  }

  _onStart(BattleEvent event, Emitter<BattleState> emit) {
    _timerBloc.add(TimerStarted(duration: _timerBloc.state.duration));
  }
}
