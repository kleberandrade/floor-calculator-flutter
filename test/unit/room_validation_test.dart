import 'package:floor_calculator/models/room_model.dart';
import 'package:floor_calculator/validations/room_validation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RoomValidation validator;
  setUpAll(() async {
    validator = RoomValidation(await loadL10n());
  });

  test('rejeita largura e comprimento zero', () {
    final result = validator.validate(RoomModel());
    expect(result.isValid, false);
    expect(result.exceptions.length, 2);
    expect(result.exceptions.map((e) => e.key), containsAll(['width', 'length']));
  });

  test('aceita valores positivos', () {
    final result = validator.validate(
      RoomModel(name: 'Sala', width: 3.0, length: 4.0),
    );
    expect(result.isValid, true);
  });

  test('aceita nome vazio (não é validado)', () {
    final result = validator.validate(RoomModel(width: 1, length: 1));
    expect(result.isValid, true);
  });
}
