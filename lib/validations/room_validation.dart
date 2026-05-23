import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/models/room_model.dart';
import 'package:lucid_validation/lucid_validation.dart';

class RoomValidation extends LucidValidator<RoomModel> {
  RoomValidation(AppLocalizations l10n) {
    ruleFor((room) => room.width, key: 'width')
        .greaterThan(0, message: l10n.validatorRoomWidth);

    ruleFor((room) => room.length, key: 'length')
        .greaterThan(0, message: l10n.validatorRoomLength);
  }
}
