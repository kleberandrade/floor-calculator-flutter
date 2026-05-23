import 'package:floor_calculator/features/mortar/mortar_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MortarCalculator', () {
    test('piso 60x60 em 100 m² usa ~5 kg/m² → 25 sacos de 20kg', () {
      final result = MortarCalculator.calculate(
        const MortarInput(
          areaM2: 100,
          tileWidthCm: 60,
          tileLengthCm: 60,
          jointWidthMm: 2,
        ),
      );
      // 5 kg/m² × 100 = 500 kg / 20 = 25 sacos
      expect(result.adhesiveBags20kg, 25);
      expect(result.adhesiveKg, closeTo(500, 0.1));
      expect(result.groutKg, greaterThan(0));
    });

    test('piso pequeno (30x30) usa taxa menor de 4 kg/m²', () {
      final result = MortarCalculator.calculate(
        const MortarInput(
          areaM2: 50,
          tileWidthCm: 30,
          tileLengthCm: 30,
          jointWidthMm: 3,
        ),
      );
      expect(result.adhesiveKg, closeTo(200, 0.1));
      expect(result.adhesiveBags20kg, 10);
    });

    test('piso grande (90x90) usa 6 kg/m²', () {
      final result = MortarCalculator.calculate(
        const MortarInput(
          areaM2: 10,
          tileWidthCm: 90,
          tileLengthCm: 90,
          jointWidthMm: 2,
        ),
      );
      expect(result.adhesiveKg, closeTo(60, 0.1));
      expect(result.adhesiveBags20kg, 3); // ceil(60/20) = 3
    });

    test('rejunte aumenta com a largura da junta', () {
      const base = MortarInput(
        areaM2: 100,
        tileWidthCm: 60,
        tileLengthCm: 60,
        jointWidthMm: 2,
      );
      const wider = MortarInput(
        areaM2: 100,
        tileWidthCm: 60,
        tileLengthCm: 60,
        jointWidthMm: 5,
      );
      final r1 = MortarCalculator.calculate(base);
      final r2 = MortarCalculator.calculate(wider);
      expect(r2.groutKg, greaterThan(r1.groutKg));
    });
  });
}
