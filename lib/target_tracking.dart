import 'package:flutter/material.dart';
import 'package:targeted_archer/scoring.dart';
import 'targets.dart';
class TargetTrackingWidget extends StatefulWidget {

  State<StatefulWidget> createState() {
    return _TargetTrackingState();
  }
}
class _TargetTrackingState extends State<TargetTrackingWidget> {
  int optionSelected = 0;
  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            for (int i = 0; i < targets.length; i++)
              TargetOption(
                targets[i]['target'] as String,
                img: targets[i]['img'] as String,
                onTap: () => checkOption(i + 1),
               selected: i + 1 == optionSelected,
              )
          ],
        ),
      ),
    );
  }
}
class TargetOption extends StatelessWidget {
  const TargetOption(this.title, {
    Key key,
    this.img,
    this.onTap,
    this.selected,
  }) : super(key: key);

  final String title;
  final String img;
  final VoidCallback onTap;
  final bool selected;

  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.lightGreen, width: 3)
        ),
    child: Ink.image(
      fit: BoxFit.cover,
      image: AssetImage(img),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Scoring(targetImage: img,)),
          );
        },
        child: Align(
          alignment: Alignment.bottomRight,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.all(4.0),
            child: Row(children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selected ?? false
                      ? Colors.blue.withOpacity(0.9)
                      : Colors.black87.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
            ]),
          ),
        ),
      ),
    )
    );
  }
}