import 'package:floor_calculator/features/paint/paint_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaintCalculator', () {
    test('100 m² em 2 demãos com 10 m²/L = 20 L → 1 lata de 18L + 1 galão', () {
      final result = PaintCalculator.calculate(
        const PaintInput(areaM2: 100, coats: 2, yieldM2PerLiter: 10),
      );
      expect(result.totalLiters, closeTo(20.0, 0.001));
      expect(result.cans18L, 1);
      // 20 - 18 = 2L restantes → 1 galão de 3,6L
      expect(result.cans3_6L, 1);
    });

    test('36 m² em 2 demãos com 12 m²/L = 6 L → 0 lata + 2 galões', () {
      final result = PaintCalculator.calculate(
        const PaintInput(areaM2: 36, coats: 2, yieldM2PerLiter: 12),
      );
      expect(result.totalLiters, closeTo(6.0, 0.001));
      expect(result.cans18L, 0);
      expect(result.cans3_6L, 2); // ceil(6 / 3.6) = 2
    });

    test('valores inválidos retornam zero', () {
      final result = PaintCalculator.calculate(
        const PaintInput(areaM2: 0, coats: 0, yieldM2PerLiter: 0),
      );
      expect(result.totalLiters, 0);
      expect(result.cans18L, 0);
      expect(result.cans3_6L, 0);
    });
  });
}
