import 'dart:math' as math;

class MortarInput {
  final double areaM2;
  final double tileWidthCm;
  final double tileLengthCm;
  final double jointWidthMm;

  const MortarInput({
    required this.areaM2,
    required this.tileWidthCm,
    required this.tileLengthCm,
    required this.jointWidthMm,
  });
}

class MortarResult {
  /// Sacos de 20 kg de argamassa colante (AC-II)
  final int adhesiveBags20kg;

  /// Total de argamassa colante em kg (antes do arredondamento)
  final double adhesiveKg;

  /// Total de rejunte em kg
  final double groutKg;

  const MortarResult({
    required this.adhesiveBags20kg,
    required this.adhesiveKg,
    required this.groutKg,
  });
}

class MortarCalculator {
  /// AC-II: consumo médio por m² depende da dimensão do piso.
  /// - peças até 40 cm: ~4 kg/m²
  /// - peças entre 40 e 60 cm: ~5 kg/m²
  /// - peças acima de 60 cm (porcelanato grande): ~6 kg/m²
  static double _adhesiveKgPerM2(double largestSideCm) {
    if (largestSideCm <= 0) return 4.0;
    if (largestSideCm < 40) return 4.0;
    if (largestSideCm <= 60) return 5.0;
    return 6.0;
  }

  /// Rejunte (kg/m²) seguindo a fórmula aproximada:
  ///   kg/m² = ((L + C) / (L * C)) * J * E * d
  /// onde:
  ///   L, C = lados do piso em cm
  ///   J    = largura da junta em cm
  ///   E    = espessura do piso/rejunte (~0,6 cm)
  ///   d    = densidade do rejunte (1,6 g/cm³ = 1,6 kg/L)
  static double _groutKgPerM2({
    required double widthCm,
    required double lengthCm,
    required double jointWidthMm,
  }) {
    if (widthCm <= 0 || lengthCm <= 0 || jointWidthMm <= 0) return 0;
    const thicknessCm = 0.6;
    const density = 1.6;
    final jointCm = jointWidthMm / 10.0;
    final unitArea = widthCm * lengthCm; // cm²
    final perimeter = 2 * (widthCm + lengthCm); // cm
    // Volume de rejunte por piso (cm³): perímetro * espessura * junta / 2
    // (cada junta é compartilhada entre duas peças -> divide por 2)
    final groutVolumePerTile = perimeter * thicknessCm * jointCm / 2;
    // Pisos por m² = 10000 cm² / unitArea
    final tilesPerM2 = 10000.0 / unitArea;
    final volumeM2 = groutVolumePerTile * tilesPerM2;
    return volumeM2 * density / 1000.0; // cm³ * kg/L => 1 cm³ = 1 mL
    // Nota: volume está em cm³, densidade em kg/L (1 L = 1000 cm³).
  }

  static MortarResult calculate(MortarInput input) {
    if (input.areaM2 <= 0) {
      return const MortarResult(
        adhesiveBags20kg: 0,
        adhesiveKg: 0,
        groutKg: 0,
      );
    }
    final largestSide = math.max(input.tileWidthCm, input.tileLengthCm);
    final adhesiveRate = _adhesiveKgPerM2(largestSide);
    final adhesiveKg = adhesiveRate * input.areaM2;
    final bags = (adhesiveKg / 20.0).ceil();
    final groutKg = _groutKgPerM2(
          widthCm: input.tileWidthCm,
          lengthCm: input.tileLengthCm,
          jointWidthMm: input.jointWidthMm,
        ) *
        input.areaM2;
    return MortarResult(
      adhesiveBags20kg: bags,
      adhesiveKg: adhesiveKg,
      groutKg: groutKg,
    );
  }
}
