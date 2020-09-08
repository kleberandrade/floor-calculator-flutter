class Validator {
  static String isEmptyText(String text) {
    if (text.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
