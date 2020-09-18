import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Cálculo", () {
    final controller = CalculatorController();
    controller.setRoomWidth('2.4');
    controller.setRoomLength('3.22');
    controller.setFloorWidth('0.6');
    controller.setFloorLength('0.6');

    final result = controller.calculate();

    test("Quantidade de pisos", () {
      expect(result.amountPieces, 24);
    });

    test("Quantidade de pisos para o rodapé", () {
      expect(result.amountFloor, 10);
    });

    test("Quantidade total de pisos", () {
      expect(result.amountPiecesAndFooter, 34);
    });

    test("Metragem quadrada total sem rodapé", () {
      expect(result.areaWithoutFooter, 8.64);
    });

    test("Metragem quadrada total com rodapé", () {
      expect(result.areaWithFooter, 12.24);
    });
  });
}
