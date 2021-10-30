import 'package:flutter/material.dart';

import 'dart:math';


class ArrowSelector extends StatelessWidget {
static double totalWidth = 25.0;
static double totalHeight = 25.0;
final double boxSize = 25.0;

final Color colour;
final bool flippedX;
final bool flippedY;

const ArrowSelector(this.colour, this.flippedX, this.flippedY);

@override
Widget build(BuildContext context) {
  return Transform(
    transform: Matrix4.identity()
      ..rotateY((flippedX ? 180 : 0) / 180 * pi)
      ..rotateX((flippedY ? 180 : 0) / 180 * pi),
    child: Transform.translate(
      offset: Offset(-12.0,15.0),
      //offset: flippedY ? Offset(0.0, -2 * totalHeight) : Offset(0.0, 0.0),
      child: Container(
        width: totalWidth,
        height: totalHeight,
        child: Image.asset('assets/arrow_hole_transparent_background.png',
          fit:BoxFit.fitWidth,
      ),
       /* child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                child: Image.asset(
                  'assets/arrow_hole_transparent_background.png',
                  scale: 7.0,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: colour,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        "10",
                        style: TextStyle(color: Colors.black, fontSize: 12, )
                    )
                ),
              ),
            ),
          ],
        ),*/
      ),
    ),
  );
}
}
