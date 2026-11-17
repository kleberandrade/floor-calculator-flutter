/// Accept decimal comma or point, never grouping or non-finite values.
double? parseNumber(String text) {
  final normalized = text.trim().replaceAll(',', '.');
  if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(normalized)) return null;
  final value = double.tryParse(normalized);
  return value != null && value.isFinite ? value : null;
}

/// Immutable estimate for an aligned rectangular layout, without cut reuse.
class Estimate {
  const Estimate._(
    this.columns,
    this.rows,
    this.skirtingPieces,
    this.requiredPieces,
    this.boxes,
    this.purchasePieces,
    this.roomArea,
    this.tileArea,
  );

  final int columns,
      rows,
      skirtingPieces,
      requiredPieces,
      boxes,
      purchasePieces;
  final double roomArea, tileArea;
  int get floorPieces => columns * rows;
  double get purchaseArea => purchasePieces * tileArea;

  factory Estimate.calculate({
    required double roomWidth,
    required double roomLength,
    required double tileWidthCm,
    required double tileLengthCm,
    double wastePercent = 0,
    int piecesPerBox = 1,
    bool includeSkirting = false,
  }) {
    for (final value in [roomWidth, roomLength, tileWidthCm, tileLengthCm]) {
      if (!value.isFinite || value <= 0 || value > 100000) {
        throw ArgumentError(
          'Dimensions must be finite, positive and ≤ 100000.',
        );
      }
    }
    if (!wastePercent.isFinite ||
        wastePercent < 0 ||
        wastePercent > 100 ||
        piecesPerBox < 1 ||
        piecesPerBox > 10000) {
      throw ArgumentError('Invalid waste percentage or box size.');
    }
    final columns = _ceil(roomWidth / (tileWidthCm / 100));
    final rows = _ceil(roomLength / (tileLengthCm / 100));
    if (columns * rows > 10000000) {
      throw ArgumentError('Estimate exceeds ten million pieces.');
    }
    final skirting = includeSkirting ? columns + rows : 0;
    final required = _ceil(
      (columns * rows + skirting) * (1 + wastePercent / 100),
    );
    final boxes = _ceil(required / piecesPerBox);
    return Estimate._(
      columns,
      rows,
      skirting,
      required,
      boxes,
      boxes * piecesPerBox,
      roomWidth * roomLength,
      tileWidthCm * tileLengthCm / 10000,
    );
  }

  // Correct only floating point noise around an exact integer.
  static int _ceil(double value) {
    if (!value.isFinite || value > 1000000000) {
      throw ArgumentError('Estimate exceeds supported quantities.');
    }
    if (value == 0) return 1; // Positive dimensions can underflow in division.
    final rounded = value.round();
    return rounded > 0 && (value - rounded).abs() < 1e-9
        ? rounded
        : value.ceil();
  }
}
