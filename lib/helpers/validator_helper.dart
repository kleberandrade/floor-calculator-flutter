class ValidatorHelper {
  static String isEmptyOrNegative(String value) {
    if (value.isEmpty)
    else if (double.tryParse(value) <= 0 ?? 0.0) return 'Valor inválido';
    else return null;
  }
}
