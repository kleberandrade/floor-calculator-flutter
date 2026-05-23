import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:floor_calculator/models/result_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calculatorProvider = ChangeNotifierProvider<CalculatorController>((ref) {
  return CalculatorController(
    defaultRoomName: (i) => 'Cômodo $i',
  );
});

final lastResultProvider = StateProvider<ResultModel?>((ref) => null);
