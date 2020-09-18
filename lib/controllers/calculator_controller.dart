import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:floor_calculator/models/floor_model.dart';
import 'package:floor_calculator/models/result_model.dart';
import 'package:floor_calculator/models/room_model.dart';

class CalculatorController {
  final room = new RoomModel();
  final floor = new FloorModel();

  void setRoomWidth(String value) {
    room.width = ParseHelper.toDouble(value);
  }

  void setRoomLength(String value) {
    room.length = ParseHelper.toDouble(value);
  }

  void setFloorWidth(String value) {
    floor.width = ParseHelper.toDouble(value);
  }

  void setFloorLength(String value) {
    floor.length = ParseHelper.toDouble(value);
  }

  ResultModel calculate() {
    final result = new ResultModel();
    result.piecesByWidth = (room.width / floor.width).ceil();
    result.piecesByLength = (room.length / floor.length).ceil();
    result.areaFloor = floor.length * floor.width;
    return result;
  }
}
