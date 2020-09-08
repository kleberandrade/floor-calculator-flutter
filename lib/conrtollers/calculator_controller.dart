import 'package:floor_calculator/models/result_model.dart';
import 'package:floor_calculator/models/floor_model.dart';
import 'package:floor_calculator/models/room_model.dart';

class CalculatorController {
  final floor = FloorModel();
  final room = RoomModel();

  double _parse(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }

  void setFloorWidth(String value) {
    floor.width = _parse(value);
  }

  void setFloorLength(String value) {
    floor.length = _parse(value);
  }

  void setRoomWidth(String value) {
    room.width = _parse(value);
  }

  void setRoomLength(String value) {
    room.length = _parse(value);
  }

  ResultModel calculate() {
    final result = ResultModel();
    result.piecesByWidth = (room.width / floor.width).ceil();
    result.piecesByLength = (room.length / floor.length).ceil();
    result.areaFloor = floor.length * floor.width;
    return result;
  }
}
