import 'package:floor_calculator/features/stairs/stairs_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StairsCalculator', () {
    test('270 cm de altura → 15 degraus, espelho ≈ 18 cm, piso ≈ 27 cm', () {
      final r = StairsCalculator.calculate(
        const StairsInput(totalHeightCm: 270),
      );
      // 270 / 17.5 ≈ 15.4 → round = 15 degraus
      expect(r.numberOfSteps, 15);
      // espelho = 270 / 15 = 18
      expect(r.riserCm, closeTo(18.0, 0.001));
      // piso = 63 - 2*18 = 27
      expect(r.treadCm, closeTo(27.0, 0.001));
      // comprimento total = piso * (n-1) = 27 * 14 = 378
      expect(r.totalLengthCm, closeTo(378, 0.5));
      expect(r.comfortable, true);
    });

    test('altura de 280 cm também produz Blondel confortável', () {
      final r = StairsCalculator.calculate(
        const StairsInput(totalHeightCm: 280),
      );
      final blondel = 2 * r.riserCm + r.treadCm;
      expect(blondel, greaterThanOrEqualTo(60));
      expect(blondel, lessThanOrEqualTo(66));
      expect(r.comfortable, true);
    });

    test('altura zero retorna tudo zero', () {
      final r = StairsCalculator.calculate(
        const StairsInput(totalHeightCm: 0),
      );
      expect(r.numberOfSteps, 0);
      expect(r.riserCm, 0);
      expect(r.treadCm, 0);
      expect(r.comfortable, false);
    });
  });
}
