import 'dart:math' as math;

class PaintInput {
  final double areaM2;
  final int coats;
  final double yieldM2PerLiter;

  const PaintInput({
    required this.areaM2,
    required this.coats,
    required this.yieldM2PerLiter,
  });
}

class PaintResult {
  final double totalLiters;
  final int cans18L;
  final int cans3_6L;

  const PaintResult({
    required this.totalLiters,
    required this.cans18L,
    required this.cans3_6L,
  });
}

class PaintCalculator {
  /// Calcula litros e quantidade de latas (18L grandes + 3,6L galões)
  /// necessários para pintar [areaM2] com [coats] demãos sob rendimento
  /// declarado pelo fabricante ([yieldM2PerLiter], normalmente 10 m²/L).
  ///
  /// Estratégia de embalagem: maximiza latas de 18L (mais barato por litro)
  /// e completa com galões de 3,6L pra cobrir o restante.
  static PaintResult calculate(PaintInput input) {
    if (input.areaM2 <= 0 ||
        input.coats <= 0 ||
        input.yieldM2PerLiter <= 0) {
      return const PaintResult(totalLiters: 0, cans18L: 0, cans3_6L: 0);
    }
    final liters = input.areaM2 * input.coats / input.yieldM2PerLiter;
    final cans18 = (liters / 18.0).floor();
    final remaining = math.max(0.0, liters - cans18 * 18.0);
    final cans3_6 = (remaining / 3.6).ceil();
    return PaintResult(
      totalLiters: liters,
      cans18L: cans18,
      cans3_6L: cans3_6,
    );
  }
}
