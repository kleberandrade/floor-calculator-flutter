// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Floor Calculator';

  @override
  String get calculatorTitle => 'Floor calculator';

  @override
  String get resultTitle => 'Result';

  @override
  String get floorDimensionsSection => 'Tile dimensions';

  @override
  String get roomsSection => 'Rooms';

  @override
  String wastageLabel(String percent) {
    return 'Waste allowance: $percent%';
  }

  @override
  String get floorWidthLabel => 'Width (cm)';

  @override
  String get floorLengthLabel => 'Length (cm)';

  @override
  String get pricePerBoxLabel => 'Price per box (\$)';

  @override
  String get piecesPerBoxLabel => 'Tiles per box';

  @override
  String get roomNameLabel => 'Room name';

  @override
  String get roomWidthLabel => 'Width (m)';

  @override
  String get roomLengthLabel => 'Length (m)';

  @override
  String get addRoom => 'Add room';

  @override
  String get removeRoom => 'Remove room';

  @override
  String get calculateButton => 'CALCULATE';

  @override
  String get shareButton => 'Share';

  @override
  String get continueButton => 'CONTINUE';

  @override
  String get clearFormTooltip => 'Clear form';

  @override
  String get clearedToast => 'Form cleared';

  @override
  String get calculateSuccessToast => 'Calculation completed';

  @override
  String get calculateErrorTitle => 'Check the form';

  @override
  String get calculateErrorDesc => 'There are invalid or missing values.';

  @override
  String get shareDoneToast => 'Estimate shared';

  @override
  String get noResultEmpty => 'No calculation yet.';

  @override
  String get quantitiesSection => 'Quantities';

  @override
  String get areasSection => 'Areas';

  @override
  String get costSection => 'Cost';

  @override
  String get perRoomSection => 'Per room';

  @override
  String get floorPiecesLabel => 'Floor tiles needed';

  @override
  String get footerPiecesLabel => 'Tiles for baseboard';

  @override
  String get totalPiecesNoWastageLabel => 'Total tiles (no waste)';

  @override
  String totalPiecesWithWastageLabel(String percent) {
    return 'Total with $percent% waste';
  }

  @override
  String get areaWithoutFooterLabel => 'Area without baseboard';

  @override
  String get areaWithFooterLabel => 'Area with baseboard';

  @override
  String boxesLabel(int count) {
    return '$count boxes';
  }

  @override
  String piecesPerBoxFootnote(int count) {
    return '$count tiles per box';
  }

  @override
  String piecesUnit(int count) {
    return '$count tiles';
  }

  @override
  String get totalCostLabel => 'Estimated total cost';

  @override
  String perRoomTileSubtitle(String name, String area) {
    return '$name — $area m²';
  }

  @override
  String get validatorFloorWidth => 'Enter a width (cm) greater than zero';

  @override
  String get validatorFloorLength => 'Enter a length (cm) greater than zero';

  @override
  String get validatorPricePerBox => 'Enter a price per box greater than zero';

  @override
  String get validatorPiecesPerBox => 'Enter how many tiles come in a box';

  @override
  String get validatorRoomWidth => 'Enter a width (m) greater than zero';

  @override
  String get validatorRoomLength => 'Enter a length (m) greater than zero';

  @override
  String defaultRoomName(int index) {
    return 'Room $index';
  }

  @override
  String get themeMenuTitle => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get languageMenuTitle => 'Language';

  @override
  String get languagePortuguese => 'Portuguese';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get shareBudgetTitle => 'Floor estimate';

  @override
  String shareFloorLine(String w, String l) {
    return 'Tile: $w x $l cm';
  }

  @override
  String shareWastageLine(String percent) {
    return 'Waste allowance: $percent%';
  }

  @override
  String get shareRoomsHeader => 'Rooms:';

  @override
  String shareRoomLine(String name, String area, int pieces) {
    return '- $name: $area m² ($pieces tiles)';
  }

  @override
  String get shareSummaryHeader => 'Summary:';

  @override
  String shareFloorPieces(int count) {
    return '- Floor tiles: $count';
  }

  @override
  String shareFooterPieces(int count) {
    return '- Baseboard tiles: $count';
  }

  @override
  String shareTotalWithWastage(int count) {
    return '- Total with waste: $count tiles';
  }

  @override
  String shareTotalArea(String area) {
    return '- Total area: $area m²';
  }

  @override
  String shareBoxes(int count) {
    return '- Boxes needed: $count';
  }

  @override
  String shareCost(String value) {
    return '- Total cost: \$ $value';
  }

  @override
  String get homeTitle => 'Construction Calculator';

  @override
  String get calculatorsSection => 'Calculators';

  @override
  String get toolsSection => 'Tools';

  @override
  String get floorCalculatorTile => 'Floor tiles';

  @override
  String get paintCalculatorTile => 'Paint';

  @override
  String get mortarCalculatorTile => 'Adhesive & grout';

  @override
  String get concreteCalculatorTile => 'Concrete';

  @override
  String get stairsCalculatorTile => 'Stairs';

  @override
  String get levelToolTile => 'Level';

  @override
  String get compassToolTile => 'Compass';

  @override
  String get flashlightToolTile => 'Flashlight';

  @override
  String get calculateAction => 'CALCULATE';

  @override
  String get resultLabel => 'Result';

  @override
  String get paintAreaLabel => 'Area to paint (m²)';

  @override
  String get paintCoatsLabel => 'Coats';

  @override
  String get paintYieldLabel => 'Coverage (m²/L)';

  @override
  String get paintYieldHint => 'Default: 10 m²/L (one latex coat)';

  @override
  String get paintTotalLiters => 'Total paint';

  @override
  String get paintCans18L => '18 L cans';

  @override
  String get paintCans3_6L => '3.6 L cans';

  @override
  String paintLitersUnit(String value) {
    return '$value L';
  }

  @override
  String get mortarAreaLabel => 'Tile area (m²)';

  @override
  String get mortarTileWidthLabel => 'Tile width (cm)';

  @override
  String get mortarTileLengthLabel => 'Tile length (cm)';

  @override
  String get mortarJointLabel => 'Joint width (mm)';

  @override
  String get mortarBagsLabel => 'Adhesive bags (20 kg)';

  @override
  String get mortarAdhesiveKgLabel => 'Total adhesive (kg)';

  @override
  String get mortarGroutKgLabel => 'Grout (kg)';

  @override
  String get concreteVolumeLabel => 'Volume (m³)';

  @override
  String get concreteMixLabel => 'Mix ratio (cement:sand:gravel)';

  @override
  String get concreteWcRatioLabel => 'Water/cement ratio (w/c)';

  @override
  String get concreteMixStructural => '1 : 2 : 3 — structural (≈ 20 MPa)';

  @override
  String get concreteMixFloor => '1 : 3 : 4 — floor slab (≈ 15 MPa)';

  @override
  String get concreteMixFoundation =>
      '1 : 4 : 6 — simple foundation (≈ 10 MPa)';

  @override
  String get concreteCementBags => '50 kg cement bags';

  @override
  String get concreteCementKg => 'Cement (kg)';

  @override
  String get concreteSand => 'Sand (m³)';

  @override
  String get concreteGravel => 'Gravel (m³)';

  @override
  String get concreteWater => 'Water (L)';

  @override
  String get stairsHeightLabel => 'Floor-to-floor height (cm)';

  @override
  String get stairsLengthLabel => 'Available run (cm) — optional';

  @override
  String get stairsSteps => 'Number of steps';

  @override
  String get stairsRiser => 'Riser (cm)';

  @override
  String get stairsTread => 'Tread (cm)';

  @override
  String get stairsTotalLength => 'Total run (cm)';

  @override
  String get stairsComfortable => 'Within Blondel comfort range';

  @override
  String get stairsNotComfortable =>
      'Outside comfort range — adjust height or step count';

  @override
  String get levelInstructions => 'Place the phone on the surface to check.';

  @override
  String get levelTiltX => 'Side tilt';

  @override
  String get levelTiltY => 'Front tilt';

  @override
  String get compassHeading => 'Heading';

  @override
  String get compassNorth => 'N';

  @override
  String get compassEast => 'E';

  @override
  String get compassSouth => 'S';

  @override
  String get compassWest => 'W';

  @override
  String get compassUnavailable => 'Compass unavailable on this device.';

  @override
  String get flashlightOn => 'Turn on';

  @override
  String get flashlightOff => 'Turn off';

  @override
  String get flashlightUnavailable => 'Flashlight unavailable on this device.';

  @override
  String get validatorPositive => 'Enter a value greater than zero';

  @override
  String get validatorPositiveInt => 'Enter an integer greater than zero';
}
