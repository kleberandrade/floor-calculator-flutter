class ParseHelper {
  static double toDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }
}
