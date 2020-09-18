class ParseHelper {
  static const double ZERO = 0.0;

  static double toDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? ZERO;
  }
}
