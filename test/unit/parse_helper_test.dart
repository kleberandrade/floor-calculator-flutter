import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ParseHelper.toDouble', () {
    test('vírgula vira ponto decimal', () {
      expect(ParseHelper.toDouble('2,5'), 2.5);
    });

    test('ponto é mantido', () {
      expect(ParseHelper.toDouble('3.14'), 3.14);
    });

    test('null retorna 0', () {
      expect(ParseHelper.toDouble(null), 0.0);
    });

    test('string vazia retorna 0', () {
      expect(ParseHelper.toDouble(''), 0.0);
    });

    test('texto inválido retorna 0', () {
      expect(ParseHelper.toDouble('abc'), 0.0);
    });
  });
}
