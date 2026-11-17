import 'package:flutter_test/flutter_test.dart';
import 'package:floor_calculator/domain/estimate.dart';

void main() {
  Estimate run({
    double width = 2.4,
    double length = 3.22,
    double tileWidth = 60,
    double tileLength = 60,
    double waste = 0,
    int perBox = 1,
    bool skirting = false,
  }) => Estimate.calculate(
    roomWidth: width,
    roomLength: length,
    tileWidthCm: tileWidth,
    tileLengthCm: tileLength,
    wastePercent: waste,
    piecesPerBox: perBox,
    includeSkirting: skirting,
  );
  test('converts centimeters and preserves row-by-row classroom example', () {
    final result = run(skirting: true);
    expect(result.columns, 4);
    expect(result.rows, 6);
    expect(result.floorPieces, 24);
    expect(result.skirtingPieces, 10);
    expect(result.requiredPieces, 34);
    expect(result.purchaseArea, closeTo(12.24, 1e-9));
    expect(result.roomArea, closeTo(7.728, 1e-9));
  });
  test('rounds waste then full boxes upward', () {
    final result = run(waste: 10, perBox: 4);
    expect(result.requiredPieces, 27);
    expect(result.boxes, 7);
    expect(result.purchasePieces, 28);
    expect(result.purchaseArea, closeTo(10.08, 1e-9));
  });
  test('does not add a phantom row for floating point multiples', () {
    expect(
      run(width: 2.1, length: 2.1, tileWidth: 30, tileLength: 30).floorPieces,
      49,
    );
  });
  test('a tiny positive room still needs one piece', () {
    expect(run(width: 1e-12, length: 1e-12).floorPieces, 1);
  });
  test('rejects invalid and impractically large quantities', () {
    for (final value in [0.0, -1.0, double.nan, double.infinity, 1e12]) {
      expect(() => run(width: value), throwsArgumentError);
      expect(() => run(tileWidth: value), throwsArgumentError);
    }
    expect(() => run(waste: -1), throwsArgumentError);
    expect(() => run(waste: 101), throwsArgumentError);
    expect(() => run(perBox: 0), throwsArgumentError);
    expect(() => run(tileWidth: 0.000001), throwsArgumentError);
    expect(() => run(tileWidth: 1e-320), throwsArgumentError);
  });
  test(
    'parses localized decimals without silently replacing invalid input',
    () {
      expect(parseNumber(' 2,40 '), 2.4);
      for (final value in ['', 'abc', 'NaN', 'Infinity', '1.000,50']) {
        expect(parseNumber(value), isNull);
      }
    },
  );
}
