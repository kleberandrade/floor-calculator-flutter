import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/models/floor_model.dart';
import 'package:lucid_validation/lucid_validation.dart';

class FloorValidation extends LucidValidator<FloorModel> {
  FloorValidation(AppLocalizations l10n) {
    ruleFor((floor) => floor.widthCm, key: 'widthCm')
        .greaterThan(0, message: l10n.validatorFloorWidth);

    ruleFor((floor) => floor.lengthCm, key: 'lengthCm')
        .greaterThan(0, message: l10n.validatorFloorLength);

    ruleFor((floor) => floor.pricePerBox, key: 'pricePerBox')
        .greaterThan(0, message: l10n.validatorPricePerBox);

    ruleFor((floor) => floor.piecesPerBox, key: 'piecesPerBox').must(
      (value) => value > 0,
      l10n.validatorPiecesPerBox,
      'pieces_per_box_invalid',
    );
  }
}
