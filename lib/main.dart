import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_generator/common/background.dart';
import 'package:words_generator/common/app_colors.dart';
import 'package:words_generator/navigation_drawer/cubit/iscollapsed_cubit.dart';
import 'package:words_generator/common/ticker.dart';
import 'package:words_generator/timer/timer.dart';
import 'package:words_generator/navigation_drawer/navigation_drawer_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tirate unos free',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
        colorScheme: ColorScheme.light(
          secondary: AppColors.champagne,
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TimerBloc(ticker: Ticker()),
        ),
        BlocProvider(
          create: (context) => IscollapsedCubit(),
        ),
      ],
      child: const WerlcomeView(),
    );
  }
}

class WerlcomeView extends StatelessWidget {
  const WerlcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Tirate unos free',
        style: AppTextStyles.appBarText,
      )),
      drawer: NavigationDrawerWidget(),
      body: Stack(
        children: [
          Background(
            colors: [
              Colors.blue.shade500,
              Theme.of(context).primaryColor,
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                  child: Center(
                    child: Text(
                      'Tirate unos Free, capo',
                      style: TextStyle(
                          color: AppColors.oliveGreen,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: AppColors.englishViolet,
                              offset: Offset(5, 5),
                            )
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
