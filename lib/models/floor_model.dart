class FloorModel {
  double widthCm;
  double lengthCm;
  double pricePerBox;
  int piecesPerBox;

  FloorModel({
    this.widthCm = 0.0,
    this.lengthCm = 0.0,
    this.pricePerBox = 0.0,
    this.piecesPerBox = 0,
  });

  double get widthMeters => widthCm / 100.0;
  double get lengthMeters => lengthCm / 100.0;
  double get areaMeters => widthMeters * lengthMeters;
}
