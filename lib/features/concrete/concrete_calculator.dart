enum ConcreteMix {
  /// 1 : 2 : 3 — concreto estrutural (~20 MPa)
  m20Structural,

  /// 1 : 3 : 4 — radier / contrapiso (~15 MPa)
  m15Floor,

  /// 1 : 4 : 6 — fundação simples / cintamento (~10 MPa)
  m10Foundation;

  /// Retorna o traço (cimento : areia : brita) em partes por volume.
  ({int cement, int sand, int gravel}) get ratio => switch (this) {
        ConcreteMix.m20Structural => (cement: 1, sand: 2, gravel: 3),
        ConcreteMix.m15Floor => (cement: 1, sand: 3, gravel: 4),
        ConcreteMix.m10Foundation => (cement: 1, sand: 4, gravel: 6),
      };
}

class ConcreteInput {
  /// Volume total a concretar em m³.
  final double volumeM3;
  final ConcreteMix mix;
  /// Fator água/cimento (a/c). 0.5 típico para estrutural; 0.6 para massa.
  final double waterCementRatio;

  const ConcreteInput({
    required this.volumeM3,
    required this.mix,
    this.waterCementRatio = 0.5,
  });
}

class ConcreteResult {
  final int cementBags50kg;
  final double cementKg;
  final double sandM3;
  final double gravelM3;
  final double waterLiters;

  const ConcreteResult({
    required this.cementBags50kg,
    required this.cementKg,
    required this.sandM3,
    required this.gravelM3,
    required this.waterLiters,
  });
}

class ConcreteCalculator {
  /// Densidade do cimento ensacado (kg por m³ aparente).
  static const double _cementDensity = 1400.0;

  /// Calcula materiais para concreto produzido em obra.
  ///
  /// Usa o método dos volumes aparentes: a soma das partes do traço é
  /// reduzida pelo fator de rendimento (~0,68) para chegar ao volume
  /// real de concreto endurecido.
  static ConcreteResult calculate(ConcreteInput input) {
    if (input.volumeM3 <= 0) {
      return const ConcreteResult(
        cementBags50kg: 0,
        cementKg: 0,
        sandM3: 0,
        gravelM3: 0,
        waterLiters: 0,
      );
    }
    final ratio = input.mix.ratio;
    const yieldFactor = 0.68; // contração entre volume aparente e real
    final parts = ratio.cement + ratio.sand + ratio.gravel;
    final cementApparentM3 =
        (ratio.cement / parts) * input.volumeM3 / yieldFactor;
    final cementKg = cementApparentM3 * _cementDensity;
    final bags = (cementKg / 50.0).ceil();
    final sandM3 = (ratio.sand / parts) * input.volumeM3 / yieldFactor;
    final gravelM3 = (ratio.gravel / parts) * input.volumeM3 / yieldFactor;
    final waterLiters = cementKg * input.waterCementRatio;
    return ConcreteResult(
      cementBags50kg: bags,
      cementKg: cementKg,
      sandM3: sandM3,
      gravelM3: gravelM3,
      waterLiters: waterLiters,
    );
  }
}
