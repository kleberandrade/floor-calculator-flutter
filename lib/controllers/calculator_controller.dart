import 'package:flutter/foundation.dart';
import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:floor_calculator/models/floor_model.dart';
import 'package:floor_calculator/models/result_model.dart';
import 'package:floor_calculator/models/room_model.dart';

typedef RoomNameBuilder = String Function(int index);

class CalculatorController extends ChangeNotifier {
  CalculatorController({RoomNameBuilder? defaultRoomName})
      : _defaultRoomName = defaultRoomName ?? ((i) => 'Room $i') {
    rooms.add(RoomModel(name: _defaultRoomName(1)));
  }

  final FloorModel floor = FloorModel();
  final List<RoomModel> rooms = [];
  double wastagePercent = 10.0;

  RoomNameBuilder _defaultRoomName;

  void updateDefaultRoomName(RoomNameBuilder builder) {
    _defaultRoomName = builder;
  }

  void addRoom() {
    rooms.add(RoomModel(name: _defaultRoomName(rooms.length + 1)));
    notifyListeners();
  }

  void removeRoom(int index) {
    if (rooms.length <= 1) return;
    rooms.removeAt(index);
    notifyListeners();
  }

  void setRoomName(int index, String value) {
    rooms[index].name = value;
  }

  void setRoomWidth(int index, String value) {
    rooms[index].width = ParseHelper.toDouble(value);
  }

  void setRoomLength(int index, String value) {
    rooms[index].length = ParseHelper.toDouble(value);
  }

  void setFloorWidth(String value) {
    floor.widthCm = ParseHelper.toDouble(value);
  }

  void setFloorLength(String value) {
    floor.lengthCm = ParseHelper.toDouble(value);
  }

  void setFloorPrice(String value) {
    floor.pricePerBox = ParseHelper.toDouble(value);
  }

  void setFloorPiecesPerBox(String value) {
    final parsed = int.tryParse(value.trim()) ?? 0;
    floor.piecesPerBox = parsed > 0 ? parsed : 0;
  }

  void setWastagePercent(double value) {
    wastagePercent = value;
    notifyListeners();
  }

  void reset() {
    floor.widthCm = 0.0;
    floor.lengthCm = 0.0;
    floor.pricePerBox = 0.0;
    floor.piecesPerBox = 0;
    wastagePercent = 10.0;
    rooms
      ..clear()
      ..add(RoomModel(name: _defaultRoomName(1)));
    notifyListeners();
  }

  ResultModel calculate() {
    final roomResults = <RoomResult>[];
    for (final room in rooms) {
      final piecesByWidth = floor.widthMeters > 0
          ? (room.width / floor.widthMeters).ceil()
          : 0;
      final piecesByLength = floor.lengthMeters > 0
          ? (room.length / floor.lengthMeters).ceil()
          : 0;
      roomResults.add(
        RoomResult(
          name: room.name.isEmpty ? _defaultRoomName(1) : room.name,
          area: room.area,
          piecesByWidth: piecesByWidth,
          piecesByLength: piecesByLength,
        ),
      );
    }
    return ResultModel(
      rooms: roomResults,
      floor: floor,
      wastagePercent: wastagePercent,
    );
  }
}
