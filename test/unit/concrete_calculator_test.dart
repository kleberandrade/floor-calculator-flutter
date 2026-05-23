import 'package:floor_calculator/features/concrete/concrete_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConcreteCalculator', () {
    test('1 m³ em traço 1:2:3 estrutural', () {
      final result = ConcreteCalculator.calculate(
        const ConcreteInput(
          volumeM3: 1,
          mix: ConcreteMix.m20Structural,
          waterCementRatio: 0.5,
        ),
      );
      // Cimento ≈ 1/6 ÷ 0.68 × 1 m³ × 1400 kg/m³ ≈ 343 kg
      expect(result.cementKg, closeTo(343.14, 1));
      expect(result.cementBags50kg, 7); // ceil(343/50)
      // a/c = 0.5 → água ≈ cementKg * 0.5
      expect(result.waterLiters, closeTo(result.cementKg * 0.5, 0.1));
    });

    test('soma das proporções: cimento + areia + brita ≈ volume / yield', () {
      final result = ConcreteCalculator.calculate(
        const ConcreteInput(
          volumeM3: 1,
          mix: ConcreteMix.m20Structural,
        ),
      );
      // volume aparente total = 1 / 0.68
      final cementApparent = result.cementKg / 1400.0;
      final sum = cementApparent + result.sandM3 + result.gravelM3;
      expect(sum, closeTo(1 / 0.68, 0.05));
    });

    test('traço de fundação 1:4:6 usa menos cimento que estrutural', () {
      final structural = ConcreteCalculator.calculate(
        const ConcreteInput(volumeM3: 1, mix: ConcreteMix.m20Structural),
      );
      final foundation = ConcreteCalculator.calculate(
        const ConcreteInput(volumeM3: 1, mix: ConcreteMix.m10Foundation),
      );
      expect(foundation.cementKg, lessThan(structural.cementKg));
    });

    test('volume zero retorna tudo zero', () {
      final result = ConcreteCalculator.calculate(
        const ConcreteInput(volumeM3: 0, mix: ConcreteMix.m20Structural),
      );
      expect(result.cementKg, 0);
      expect(result.sandM3, 0);
      expect(result.gravelM3, 0);
      expect(result.waterLiters, 0);
    });
  });
}
