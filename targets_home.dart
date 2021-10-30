import 'package:flutter/material.dart';
import 'placeholder_widget.dart';


class TargetsHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TargetsHomeState();
  }
}
class _TargetsHomeState extends State<TargetsHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.cyanAccent),
    PlaceholderWidget(Colors.pinkAccent),
    PlaceholderWidget(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            icon: new Icon(Icons.watch),
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