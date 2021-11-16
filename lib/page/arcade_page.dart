import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_generator/common/background.dart';
import 'package:words_generator/common/app_colors.dart';
import 'package:words_generator/common/ticker.dart';
import 'package:words_generator/timer/timer.dart';
import 'package:words_generator/model/word.dart';

class ArcadePage extends StatelessWidget {
  const ArcadePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TimerBloc(ticker: Ticker())),
      ],
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TimerStatus status =
        context.select((TimerBloc bloc) => bloc.state.status);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Arcade',
        style: AppTextStyles.appBarText,
      )),
      body: Stack(
        children: [
          Background(
            colors: [
              if (status == TimerStatus.pending) ...[
                Colors.blue.shade500,
                AppColors.englishViolet,
              ] else if (status == TimerStatus.running) ...[
                Colors.blue.shade500,
                Colors.white,
              ] else if (status == TimerStatus.paused) ...[
                Colors.blue.shade500,
                AppColors.rubyRed,
              ] else ...[
                Colors.blue.shade500,
                Colors.greenAccent,
              ]
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpeedWheel(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(child: TimerText()),
              ),
              Actions(),
            ],
          ),
        ],
      ),
    );
  }
}

class SpeedWheel extends StatelessWidget {
  const SpeedWheel({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        // buildWhen: (prev, state) => prev.duration != state.duration,
        builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () =>
                context.read<TimerBloc>().add(const DurationDecremented()),
            child: Icon(
              Icons.arrow_left_rounded,
              size: 50,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              state.duration.toString(),
              style: AppTextStyles.subHeading,
            ),
          ),
          FloatingActionButton(
            onPressed: () =>
                context.read<TimerBloc>().add(const DurationIncremented()),
            child: Icon(
              Icons.arrow_right_rounded,
              size: 50,
            ),
          )
        ],
      );
    });
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.remaining);
    final Word? word = context.select((TimerBloc bloc) => bloc.state.word);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Column(
      children: [
        Text(
          word?.value ?? '',
          style: AppTextStyles.word,
        ),
        Text(
          '$minutesStr:$secondsStr',
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}

class Actions extends StatelessWidget {
  Actions({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      // buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state.status == TimerStatus.pending) ...[
              FloatingActionButton(
                backgroundColor: Colors.green[300],
                child: Icon(Icons.play_arrow),
                onPressed: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.remaining)),
              ),
            ] else if (state.status == TimerStatus.running) ...[
              FloatingActionButton(
                backgroundColor: AppColors.accentColor,
                foregroundColor: Colors.white,
                child: Icon(
                  Icons.pause,
                ),
                onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
              ),
              FloatingActionButton(
                backgroundColor: AppColors.oliveGreen,
                child: Icon(Icons.change_circle),
                onPressed: () =>
                    context.read<TimerBloc>().add(RandomRequested()),
              ),
              FloatingActionButton(
                child: Icon(Icons.replay),
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
              ),
            ] else if (state.status == TimerStatus.paused) ...[
              FloatingActionButton(
                child: Icon(Icons.play_arrow),
                onPressed: () => context.read<TimerBloc>().add(TimerResumed()),
              ),
              FloatingActionButton(
                child: Icon(Icons.replay),
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
              ),
            ],
          ],
        );
      },
    );
  }
}
