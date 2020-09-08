import 'package:floor_calculator/conrtollers/calculator_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Cálculo", () {
    final controller = CalculatorController();
    controller.room.width = 2.40;
    controller.room.length = 3.22;
    controller.floor.width = 0.6;
    controller.floor.length = 0.6;

    final result = controller.calculate();

    test("Quantidade de pisos", () {
      expect(result.amountPieces, 24);
    });

    test("Quantidade de pisos para o rodapé", () {
      expect(result.amountFooter, 10);
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
