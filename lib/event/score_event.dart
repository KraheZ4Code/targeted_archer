import 'package:targeted_archer/model/score.dart';

enum EventType { add, delete }

class ScoreEvent {
  Score score;
  int scoreIndex;
  EventType eventType;

  ScoreEvent.add(Score score) {
    this.eventType = EventType.add;
    this.score = score;
  }

  ScoreEvent.delete(int index) {
    this.eventType = EventType.delete;
    this.scoreIndex = index;
  }
}