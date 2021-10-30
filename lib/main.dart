import 'package:flutter/material.dart';
import 'package:targeted_archer/bloc/score_observer.dart';
import 'target_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targeted_archer/bloc/scoreBloc.dart';
import 'package:targeted_archer/model/score.dart';
void main() {
  Bloc.observer = ScoreBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreBloc>(
        create: (context) => ScoreBloc(List<Score>()),
    child: MaterialApp(
      title: 'My Flutter App',
      home: TargetsHome(),
    ),
    );
  }
}