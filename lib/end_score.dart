import 'package:flutter/material.dart';
import 'package:targeted_archer/bloc/scoreBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targeted_archer/event/score_event.dart';
import 'package:targeted_archer/model/score.dart';

class EndScore extends StatefulWidget {
  @override
  _EndScoreState createState() => _EndScoreState();
}

class _EndScoreState extends State<EndScore> {
  _EndScoreState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        ArrowBoxes(),
        Container(
            height: 50,
            child: VerticalDivider(color: Colors.lightGreen, width: 12)),
        EndTotal("25", Colors.blueGrey),
        ScoreTotal("137", Colors.grey)
      ],
    );
  }
}

class ArrowBox extends StatelessWidget {
  String boxText;
  Color color;

  ArrowBox(this.boxText, this.color);

  @override
  Widget build(BuildContext context) {
    return new Container(
      constraints: BoxConstraints.tightFor(height: 30.0, width: 35.0),
      // height: 20
      decoration: new BoxDecoration(
          color: color,
          border: new Border.all(
              color: Colors.white, width: 2.0, style: BorderStyle.solid)),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(boxText),
      ),
    );
  }
}

class EndTotal extends StatelessWidget {
  String boxText;
  Color color;

  EndTotal(this.boxText, this.color);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "End Score",
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints.tightFor(height: 30.0, width: 75.0),
            // height: 20
            decoration: new BoxDecoration(
                color: color,
                border: new Border.all(
                    color: Colors.white, width: 2.0, style: BorderStyle.solid)),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(boxText),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreTotal extends StatelessWidget {
  String boxText;
  Color color;

  ScoreTotal(this.boxText, this.color);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                "Total Score",
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints.tightFor(height: 30.0, width: 75.0),
            // height: 20
            decoration: new BoxDecoration(
                color: color,
                border: new Border.all(
                    color: Colors.white, width: 2.0, style: BorderStyle.solid)),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(boxText),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowBoxes extends StatelessWidget {
  int endCount;
  int boxCount;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "End 1",
                ),
              ),
            ),
            Container(
            child: BlocConsumer<ScoreBloc, List<Score>>(
              buildWhen: (List<Score> previous, List<Score> current) {
                return true;
              },
              listenWhen: (List<Score> previous, List<Score> current) {
                if (current.length > previous.length) {
                  return true;
                }

                return false;
              },
              builder: (context, scoreList) {
                return ListView.builder(
                  //scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  itemCount: scoreList.length,
                  itemBuilder: (context, index) {
                    return ArrowBox(
                        scoreList[index].score.toString(), Colors.grey[350]
                        //child: ListTile(
                        //title: Text(scoreList[index].score),
                        //onTap: () => BlocProvider.of<ScoreBloc>(context).add(
                        //ScoreEvent.delete(index),
                        //),
                        //),
                        );
                  },
                );
              },
              listener: (BuildContext context, foodList) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Added!')),
                );
              },
            ),//end of Bloc
            ),
          ],
        ),
      ),
    );
  }
} /*  builder: (context, scoreList)
              )/*Row(children: <Widget>[
              ArrowBox("7", Colors.grey[350]),
              ArrowBox("10", Colors.grey[350]),
              ArrowBox("8", Colors.grey[350]),
              ArrowBox("8", Colors.grey[350]),
              ArrowBox("8", Colors.grey[350]),
              ArrowBox("8", Colors.grey[350]),

            ]),*/
          ],
        ),
      ),
    );
  }
}*/
