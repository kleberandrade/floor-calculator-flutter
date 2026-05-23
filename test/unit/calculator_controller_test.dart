import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cálculo - um cômodo', () {
    final controller = CalculatorController();
    controller.setRoomWidth(0, '2.4');
    controller.setRoomLength(0, '3.22');
    controller.setFloorWidth('60');
    controller.setFloorLength('60');
    controller.setFloorPrice('120');
    controller.setFloorPiecesPerBox('5');
    controller.setWastagePercent(0);

    final result = controller.calculate();

    test('Quantidade de pisos no chão', () {
      expect(result.totalFloorPieces, 24);
    });

    test('Quantidade de pisos para o rodapé', () {
      expect(result.totalFooterPieces, 10);
    });

    test('Quantidade total de pisos (sem perda)', () {
      expect(result.totalPiecesNoWastage, 34);
    });

    test('Metragem quadrada total sem rodapé', () {
      expect(result.areaWithoutFooter, closeTo(8.64, 0.001));
    });

    test('Metragem quadrada total com rodapé', () {
      expect(result.areaWithFooter, closeTo(12.24, 0.001));
    });

    test('Quantidade de caixas necessárias', () {
      // 34 pisos / 5 por caixa => 7 caixas (ceil)
      expect(result.totalBoxes, 7);
    });

    test('Custo total estimado', () {
      // 7 caixas * R$120 = R$840
      expect(result.totalCost, 840.0);
    });
  });

  group('Cálculo - margem de perda', () {
    final controller = CalculatorController();
    controller.setRoomWidth(0, '2.4');
    controller.setRoomLength(0, '3.22');
    controller.setFloorWidth('60');
    controller.setFloorLength('60');
    controller.setWastagePercent(10);

    final result = controller.calculate();

    test('Total com 10% de perda arredonda para cima', () {
      // ceil(34 * 1.10) = ceil(37.4) = 38
      expect(result.totalPiecesWithWastage, 38);
    });
  });

  group('Cálculo - múltiplos cômodos', () {
    final controller = CalculatorController();
    controller.setRoomName(0, 'Sala');
    controller.setRoomWidth(0, '2.4');
    controller.setRoomLength(0, '3.22');
    controller.addRoom();
    controller.setRoomName(1, 'Quarto');
    controller.setRoomWidth(1, '3.0');
    controller.setRoomLength(1, '3.0');
    controller.setFloorWidth('60');
    controller.setFloorLength('60');
    controller.setWastagePercent(0);

    final result = controller.calculate();

    test('Dois cômodos no resultado', () {
      expect(result.rooms.length, 2);
    });

    test('Soma das áreas dos cômodos', () {
      // 2.4*3.22 + 3.0*3.0 = 7.728 + 9.0 = 16.728
      expect(result.totalRoomArea, closeTo(16.728, 0.001));
    });

    test('Soma dos pisos do chão dos dois cômodos', () {
      // Sala: 4*6 = 24; Quarto: ceil(3/0.6)*ceil(3/0.6) = 5*5 = 25
      expect(result.totalFloorPieces, 49);
    });
  });

  group('Reset', () {
    test('reset volta para um cômodo vazio', () {
      final controller = CalculatorController();
      controller.addRoom();
      controller.addRoom();
      controller.setRoomWidth(0, '5');
      controller.reset();
      expect(controller.rooms.length, 1);
      expect(controller.rooms.first.width, 0.0);
      expect(controller.floor.widthCm, 0.0);
    });
  });
}
