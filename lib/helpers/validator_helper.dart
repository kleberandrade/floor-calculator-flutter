class ValidatorHelper {
  static String isValidText(String text) {
    return text.isEmpty ? 'Campo obrigatório' : null;
  }
}
