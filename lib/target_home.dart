import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'target_tracking.dart';

class TargetsHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TargetsHomeState();
  }
}
class _TargetsHomeState extends State<TargetsHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TargetTrackingWidget(),
    PlaceholderWidget(Colors.pinkAccent),
    PlaceholderWidget(Colors.greenAccent)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text('Targeted Archery'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: ('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            label: ('Saved'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ('Profile')
          )
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}