import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_generator/common/ticker.dart';
import 'package:words_generator/model/word.dart';
import 'package:http/http.dart' as http;

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _defaultDuration = 8;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker, int? duration})
      : _ticker = ticker,
        super(TimerState(
          duration: duration ?? _defaultDuration,
          status: TimerStatus.pending,
          remaining: duration ?? _defaultDuration,
        )) {
    on<TimerStarted>(_onStarted);
    on<RestartRequested>(_onRestart);
    on<NextWordRequested>(_getNextWord);
    on<DurationIncremented>(_incrementDuration);
    on<DurationDecremented>(_decrementDuration);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTicked);
    on<RandomRequested>(_getRandom);
  }
  @override
  void onChange(Change<TimerState> change) {
    super.onChange(change);
    print(change.nextState);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) async {
    _tickerSubscription?.cancel();
    var _word = await _fetchWord();
    emit(TimerState(
      remaining: event.duration,
      duration: event.duration,
      word: _word,
      status: TimerStatus.running,
    ));
    _tickerSubscription = _ticker
        .tickLoop(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _getNextWord(NextWordRequested event, Emitter<TimerState> emit) async {
    var _nextWord = await _fetchWord();
    emit(state.copyWith(nextWord: _nextWord, nextCompleted: true));
  }

  void _getRandom(RandomRequested event, Emitter<TimerState> emit) async {
    var word = await _fetchWord();
    emit(state.copyWith(word: word));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
    emit(state.copyWith(status: TimerStatus.paused));
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    _tickerSubscription?.resume();
    emit(state.copyWith(status: TimerStatus.running));
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    add(const RestartRequested());
  }

  void _onRestart(RestartRequested event, Emitter<TimerState> emit) async {
    _tickerSubscription?.cancel();
    emit(state.copyWith(
      remaining: state.duration,
      word: await _fetchWord().then((word) => word),
      nextWord: Word.empty(),
      nextCompleted: false,
      status: TimerStatus.running,
    ));
    _tickerSubscription = _ticker
        .tickLoop(ticks: state.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    if (state.remaining < (state.duration / 2).ceil() + 1 &&
        !state.nextCompleted) {
      add(NextWordRequested());
    }
    emit(state.remaining == 0
        ? state.copyWith(
            word: state.nextWord,
            remaining: state.duration,
            nextCompleted: false)
        : state.copyWith(remaining: event.duration));
  }

  Future<Word> _fetchWord() async {
    var url = Uri.parse(
      'https://palabras-aleatorias-public-api.herokuapp.com/random',
    );
    final response = await http.get(url);
    return Word.fromJson(jsonDecode(response.body));
  }

  FutureOr<void> _incrementDuration(
      DurationIncremented event, Emitter<TimerState> emit) {
    emit(state.copyWith(duration: state.duration + event.incrementedValue));
    add(RestartRequested());
  }

  FutureOr<void> _decrementDuration(
      DurationDecremented event, Emitter<TimerState> emit) {
    if (state.duration >= 3) {
      emit(state.copyWith(duration: state.duration - event.decrementedValue));
      add(RestartRequested());
    }
  }
}
