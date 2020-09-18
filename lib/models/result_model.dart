class ResultModel {
  double areaFloor;
  int piecesByWidth;
  int piecesByLength;

  ResultModel({
    this.areaFloor,
    this.piecesByWidth,
    this.piecesByLength,
  });

  get amountPieces => piecesByWidth * piecesByLength;
  get amountFloor => piecesByWidth + piecesByLength;
  get amountPiecesAndFooter => amountPieces + amountFloor;
  double get areaWithoutFooter => amountPieces * areaFloor;
  double get areaWithFooter => amountPiecesAndFooter * areaFloor;
}
