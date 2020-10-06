import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:floor_calculator/models/floor_model.dart';
import 'package:floor_calculator/models/result_model.dart';
import 'package:floor_calculator/models/room_model.dart';

class CalculatorController {
  final room = RoomModel();
  final floor = FloorModel();

  void setFloorWidth(String value) {
    floor.width = ParseHelper.toDouble(value);
  }

  void setFloorLength(String value) {
    floor.length = ParseHelper.toDouble(value);
  }

  void setFloorPrice(String value) {
    floor.price = ParseHelper.toDouble(value);
  }

  void setRoomWidth(String value) {
    room.width = ParseHelper.toDouble(value);
  }

  void setRoomLength(String value) {
    room.length = ParseHelper.toDouble(value);
  }

  ResultModel calculate() {
    final result = ResultModel();
    result.piecesByLength = (room.length / floor.length).ceil();
    result.piecesByWidth = (room.width / floor.width).ceil();
    result.areaFloor = floor.length * floor.width;
    result.totalPrice = floor.price * result.amountPiecesAndFooter;
    return result;
  }
}
