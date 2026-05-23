import 'package:floor_calculator/models/floor_model.dart';

class RoomResult {
  final String name;
  final double area;
  final int piecesByWidth;
  final int piecesByLength;

  RoomResult({
    required this.name,
    required this.area,
    required this.piecesByWidth,
    required this.piecesByLength,
  });

  int get floorPieces => piecesByWidth * piecesByLength;
  int get footerPieces => piecesByWidth + piecesByLength;
  int get totalPieces => floorPieces + footerPieces;
}

class ResultModel {
  final List<RoomResult> rooms;
  final FloorModel floor;
  final double wastagePercent;

  ResultModel({
    required this.rooms,
    required this.floor,
    this.wastagePercent = 0.0,
  });

  double get totalRoomArea =>
      rooms.fold(0.0, (sum, r) => sum + r.area);

  int get totalFloorPieces =>
      rooms.fold(0, (sum, r) => sum + r.floorPieces);

  int get totalFooterPieces =>
      rooms.fold(0, (sum, r) => sum + r.footerPieces);

  int get totalPiecesNoWastage => totalFloorPieces + totalFooterPieces;

  int get totalPiecesWithWastage =>
      (totalPiecesNoWastage * (1 + wastagePercent / 100.0)).ceil();

  double get areaWithoutFooter => totalFloorPieces * floor.areaMeters;

  double get areaWithFooter => totalPiecesNoWastage * floor.areaMeters;

  int get totalBoxes {
    if (floor.piecesPerBox <= 0) return 0;
    return (totalPiecesWithWastage / floor.piecesPerBox).ceil();
  }

  double get totalCost => totalBoxes * floor.pricePerBox;
}
