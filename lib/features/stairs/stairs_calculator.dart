class StairsInput {
  /// Altura total piso-a-piso, em centímetros.
  final double totalHeightCm;
  /// Vão horizontal disponível para a escada (opcional, em cm).
  final double? availableLengthCm;

  const StairsInput({required this.totalHeightCm, this.availableLengthCm});
}

class StairsResult {
  final int numberOfSteps;
  final double riserCm;
  final double treadCm;
  final double totalLengthCm;
  /// True se o resultado respeita a fórmula de Blondel (60 <= 2e+p <= 66).
  final bool comfortable;

  const StairsResult({
    required this.numberOfSteps,
    required this.riserCm,
    required this.treadCm,
    required this.totalLengthCm,
    required this.comfortable,
  });
}

class StairsCalculator {
  /// Espelho ideal (cm): conforto entre 16 e 18 cm; pegamos 17,5.
  static const double _idealRiser = 17.5;

  /// Aplica a fórmula de Blondel para dimensionar uma escada reta:
  ///   2 * espelho + piso = 63 (±3)
  ///
  /// Estratégia: calcula o número de degraus dividindo a altura por um
  /// espelho ideal, depois ajusta o espelho para distribuir uniformemente,
  /// e deriva o piso por Blondel.
  static StairsResult calculate(StairsInput input) {
    if (input.totalHeightCm <= 0) {
      return const StairsResult(
        numberOfSteps: 0,
        riserCm: 0,
        treadCm: 0,
        totalLengthCm: 0,
        comfortable: false,
      );
    }
    final estimatedSteps =
        (input.totalHeightCm / _idealRiser).round().clamp(1, 99);
    final riser = input.totalHeightCm / estimatedSteps;
    final tread = 63.0 - 2 * riser;
    final totalLength = tread * (estimatedSteps - 1);
    final blondelValue = 2 * riser + tread;
    final comfortable = blondelValue >= 60 && blondelValue <= 66;
    return StairsResult(
      numberOfSteps: estimatedSteps,
      riserCm: riser,
      treadCm: tread,
      totalLengthCm: totalLength,
      comfortable: comfortable,
    );
  }
}
