import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:targeted_archer/arrow_selector.dart';
import 'package:targeted_archer/bloc/scoreBloc.dart';
import 'package:targeted_archer/event/score_event.dart';
import 'package:targeted_archer/model/score.dart';
import 'end_score.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';


class Scoring extends StatefulWidget {
  static const routeName = '/color/selection';
  final String targetImage;

  const Scoring ({Key key, @required this.targetImage}) : super(key: key);

  @override
  _ScoringState createState() => _ScoringState();

}

class _ScoringState extends State<Scoring> {
  File _image;
  final picker = ImagePicker();
  AssetImage scoringImage = AssetImage('assets/wa_5_ring.png');
  Positioned dropper = Positioned(
    child: Container(width: 0.0, height: 0.0),
  );
  Color currentSelection;
  int currentScore;

  Future _getImage(camOrGal) async {
    ImageSource source;

    camOrGal == 'camera'
        ? source = ImageSource.camera
        : source = ImageSource.gallery;

    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (widget.targetImage != null) {
        //_image = widget.targetImage;
       // _image= File("assets/wa_5_ring.png");
        scoringImage = AssetImage(widget.targetImage);
        print("Image value: ${widget.targetImage}");
      } else {
        print(
            'No image selected - if you\'re seeing this something is really wrong');
      }
    });
  }

  void _screenTouched(dynamic details, ImgDetails img, RenderBox box) {

    double widgetScale = box.size.width / img.width;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    var x = (localOffset.dx / widgetScale).round();
    var y = (localOffset.dy / widgetScale).round();
    bool flippedX = box.size.width - localOffset.dx < ArrowSelector.totalWidth;
    bool flippedY = localOffset.dy < ArrowSelector.totalHeight;
    if (box.size.height - localOffset.dy > 0 && localOffset.dy > 0) {
      currentSelection = img.pixelColorAt(x, y);
      setState(() {
        _createDropper(localOffset.dx, box.size.height - localOffset.dy,
            img.pixelColorAt(x, y), flippedX, flippedY);
      });
    }
    if (currentSelection == Color(0xff00b4e4)){
      currentScore = 6;
    }
    else if (currentSelection == Color(0xffee323b)){
      currentScore = 8;
    }
    else if(currentSelection == Color(0xffffe552)){
      currentScore = 10;
    }
    print("Colour: $currentSelection");
    BlocProvider.of<ScoreBloc>(context).add(
       ScoreEvent.add(Score(currentScore)));
  }

  void _createDropper(
      left, bottom, Color colour, bool flippedX, bool flippedY) {
    dropper = Positioned(
      left: left,
      bottom: bottom,
      child: ArrowSelector(colour, flippedX, flippedY),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
       /* title: Image.asset(
          'assets/images/LAETUS_LOGO.png',
          width: 120,
        ),*/
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
      ),*/
      body: Center(
        child: Container(
        child: Column(
          children: <Widget>[
            Container(margin: EdgeInsets.only(bottom: 4,), decoration:BoxDecoration( border: Border(
          bottom: BorderSide(
              width: 1.0
          ),
          ),
        ),
        //child:EndScore(),
            ),
            Stack(
            children:<Widget>[
              InteractiveViewer(
                child: ImagePixels(
                imageProvider: scoringImage,
                builder: (BuildContext context, ImgDetails img) {
                  return GestureDetector(
                    child: Image(image: scoringImage),
                    //onPanUpdate: (DragUpdateDetails details) {
                    //  _screenTouched(details, img, context.findRenderObject());
                   // },
                    onLongPressEnd: (LongPressEndDetails details) {
                      _screenTouched(details, img, context.findRenderObject());
                    },
                  );
                }),),
            dropper,
              ],
        ),
      ],
    ),
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "hiddenButton",
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(),
            onPressed: () => {},
          ),
          Builder(
            builder: (context) => FloatingActionButton(
                heroTag: "addPhotoButton",
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? Icon(CupertinoIcons.camera)
                    : Icon(Icons.add_a_photo),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Color(0xFF737373),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: Text('Gallery'),
                                  onTap: () {
                                    _getImage('gallery');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                    leading: Icon(Icons.photo_camera),
                                    title: Text('Camera'),
                                    onTap: () {
                                      _getImage('camera');
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
          FloatingActionButton(
              heroTag: "colorDetailsButton",
              backgroundColor: currentSelection,
              child: Center(
                child: Text(
                    "$currentScore",
                    style: TextStyle(color: Colors.black, fontSize: 20, )
                ),
              ),
              onPressed: () {
                print("Image value: $_image");
                if (currentSelection != null && _image != null) {
                 /* Navigator.pushNamed(
                    context,
                    ColorDetailsScreen.routeName,
                    arguments:
                    ExtractArguments(FileImage(_image), currentSelection),
                  );*/
                }
              }),
        ],
      ),
    );
  }
}
