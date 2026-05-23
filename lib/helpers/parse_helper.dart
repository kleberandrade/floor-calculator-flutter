class ParseHelper {
  static double toDouble(String? value) {
    if (value == null) return 0.0;
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }
}
