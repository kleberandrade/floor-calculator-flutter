import 'package:floor_calculator/models/floor_model.dart';
import 'package:floor_calculator/validations/floor_validation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FloorValidation - pt', () {
    late FloorValidation validator;

    setUpAll(() async {
      final l10n = await loadL10n(const Locale('pt'));
      validator = FloorValidation(l10n);
    });

    test('rejeita largura zero', () {
      final floor = FloorModel(widthCm: 0);
      final result = validator.validate(floor);
      expect(result.isValid, false);
      expect(
        result.exceptions.any((e) => e.key == 'widthCm'),
        true,
      );
    });

    test('aceita largura positiva', () {
      final floor = FloorModel(
        widthCm: 60,
        lengthCm: 60,
        pricePerBox: 120,
        piecesPerBox: 5,
      );
      final result = validator.validate(floor);
      expect(result.isValid, true);
    });

    test('rejeita pisos por caixa zero', () {
      final floor = FloorModel(
        widthCm: 60,
        lengthCm: 60,
        pricePerBox: 120,
        piecesPerBox: 0,
      );
      final result = validator.validate(floor);
      expect(
        result.exceptions.any((e) => e.key == 'piecesPerBox'),
        true,
      );
    });

    test('mensagem em português', () {
      final floor = FloorModel();
      final result = validator.validate(floor);
      final msg =
          result.exceptions.firstWhere((e) => e.key == 'widthCm').message;
      expect(msg, contains('largura'));
    });
  });

  group('FloorValidation - en', () {
    test('mensagem em inglês', () async {
      final l10n = await loadL10n(const Locale('en'));
      final validator = FloorValidation(l10n);
      final result = validator.validate(FloorModel());
      final msg =
          result.exceptions.firstWhere((e) => e.key == 'widthCm').message;
      expect(msg.toLowerCase(), contains('width'));
    });
  });

  group('FloorValidation - es', () {
    test('mensagem em espanhol', () async {
      final l10n = await loadL10n(const Locale('es'));
      final validator = FloorValidation(l10n);
      final result = validator.validate(FloorModel());
      final msg =
          result.exceptions.firstWhere((e) => e.key == 'widthCm').message;
      expect(msg.toLowerCase(), contains('ancho'));
    });
  });
}
