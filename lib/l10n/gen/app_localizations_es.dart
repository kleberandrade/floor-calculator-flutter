// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Calculadora de Pisos';

  @override
  String get calculatorTitle => 'Calculadora de pisos';

  @override
  String get resultTitle => 'Resultado';

  @override
  String get floorDimensionsSection => 'Dimensiones de la baldosa';

  @override
  String get roomsSection => 'Habitaciones';

  @override
  String wastageLabel(String percent) {
    return 'Margen de pérdida: $percent%';
  }

  @override
  String get floorWidthLabel => 'Ancho (cm)';

  @override
  String get floorLengthLabel => 'Largo (cm)';

  @override
  String get pricePerBoxLabel => 'Precio por caja (\$)';

  @override
  String get piecesPerBoxLabel => 'Baldosas por caja';

  @override
  String get roomNameLabel => 'Nombre de la habitación';

  @override
  String get roomWidthLabel => 'Ancho (m)';

  @override
  String get roomLengthLabel => 'Largo (m)';

  @override
  String get addRoom => 'Añadir habitación';

  @override
  String get removeRoom => 'Quitar habitación';

  @override
  String get calculateButton => 'CALCULAR';

  @override
  String get shareButton => 'Compartir';

  @override
  String get continueButton => 'CONTINUAR';

  @override
  String get clearFormTooltip => 'Limpiar formulario';

  @override
  String get clearedToast => 'Formulario limpio';

  @override
  String get calculateSuccessToast => 'Cálculo realizado';

  @override
  String get calculateErrorTitle => 'Revisa el formulario';

  @override
  String get calculateErrorDesc => 'Hay valores no válidos o faltantes.';

  @override
  String get shareDoneToast => 'Presupuesto compartido';

  @override
  String get noResultEmpty => 'Aún no hay cálculo.';

  @override
  String get quantitiesSection => 'Cantidades';

  @override
  String get areasSection => 'Áreas';

  @override
  String get costSection => 'Costo';

  @override
  String get perRoomSection => 'Por habitación';

  @override
  String get floorPiecesLabel => 'Baldosas para el piso';

  @override
  String get footerPiecesLabel => 'Baldosas para el zócalo';

  @override
  String get totalPiecesNoWastageLabel => 'Total (sin pérdida)';

  @override
  String totalPiecesWithWastageLabel(String percent) {
    return 'Total con $percent% de pérdida';
  }

  @override
  String get areaWithoutFooterLabel => 'Metraje sin zócalo';

  @override
  String get areaWithFooterLabel => 'Metraje con zócalo';

  @override
  String boxesLabel(int count) {
    return '$count cajas';
  }

  @override
  String piecesPerBoxFootnote(int count) {
    return '$count baldosas por caja';
  }

  @override
  String piecesUnit(int count) {
    return '$count baldosas';
  }

  @override
  String get totalCostLabel => 'Costo total estimado';

  @override
  String perRoomTileSubtitle(String name, String area) {
    return '$name — $area m²';
  }

  @override
  String get validatorFloorWidth => 'Ingrese un ancho (cm) mayor que cero';

  @override
  String get validatorFloorLength => 'Ingrese un largo (cm) mayor que cero';

  @override
  String get validatorPricePerBox =>
      'Ingrese un precio por caja mayor que cero';

  @override
  String get validatorPiecesPerBox =>
      'Indique cuántas baldosas vienen en la caja';

  @override
  String get validatorRoomWidth => 'Ingrese un ancho (m) mayor que cero';

  @override
  String get validatorRoomLength => 'Ingrese un largo (m) mayor que cero';

  @override
  String defaultRoomName(int index) {
    return 'Habitación $index';
  }

  @override
  String get themeMenuTitle => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get languageMenuTitle => 'Idioma';

  @override
  String get languagePortuguese => 'Portugués';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get shareBudgetTitle => 'Presupuesto de pisos';

  @override
  String shareFloorLine(String w, String l) {
    return 'Baldosa: $w x $l cm';
  }

  @override
  String shareWastageLine(String percent) {
    return 'Margen de pérdida: $percent%';
  }

  @override
  String get shareRoomsHeader => 'Habitaciones:';

  @override
  String shareRoomLine(String name, String area, int pieces) {
    return '- $name: $area m² ($pieces baldosas)';
  }

  @override
  String get shareSummaryHeader => 'Resumen:';

  @override
  String shareFloorPieces(int count) {
    return '- Baldosas del piso: $count';
  }

  @override
  String shareFooterPieces(int count) {
    return '- Baldosas del zócalo: $count';
  }

  @override
  String shareTotalWithWastage(int count) {
    return '- Total con pérdida: $count baldosas';
  }

  @override
  String shareTotalArea(String area) {
    return '- Área total: $area m²';
  }

  @override
  String shareBoxes(int count) {
    return '- Cajas necesarias: $count';
  }

  @override
  String shareCost(String value) {
    return '- Costo total: \$ $value';
  }

  @override
  String get homeTitle => 'Calculadora de Obra';

  @override
  String get calculatorsSection => 'Calculadoras';

  @override
  String get toolsSection => 'Herramientas';

  @override
  String get floorCalculatorTile => 'Baldosas';

  @override
  String get paintCalculatorTile => 'Pintura';

  @override
  String get mortarCalculatorTile => 'Pegamento y lechada';

  @override
  String get concreteCalculatorTile => 'Hormigón';

  @override
  String get stairsCalculatorTile => 'Escalera';

  @override
  String get levelToolTile => 'Nivel';

  @override
  String get compassToolTile => 'Brújula';

  @override
  String get flashlightToolTile => 'Linterna';

  @override
  String get calculateAction => 'CALCULAR';

  @override
  String get resultLabel => 'Resultado';

  @override
  String get paintAreaLabel => 'Área a pintar (m²)';

  @override
  String get paintCoatsLabel => 'Manos';

  @override
  String get paintYieldLabel => 'Rendimiento (m²/L)';

  @override
  String get paintYieldHint => 'Por defecto: 10 m²/L (una mano de látex)';

  @override
  String get paintTotalLiters => 'Pintura total';

  @override
  String get paintCans18L => 'Latas de 18 L';

  @override
  String get paintCans3_6L => 'Galones de 3,6 L';

  @override
  String paintLitersUnit(String value) {
    return '$value L';
  }

  @override
  String get mortarAreaLabel => 'Área a colocar (m²)';

  @override
  String get mortarTileWidthLabel => 'Ancho de la baldosa (cm)';

  @override
  String get mortarTileLengthLabel => 'Largo de la baldosa (cm)';

  @override
  String get mortarJointLabel => 'Ancho de la junta (mm)';

  @override
  String get mortarBagsLabel => 'Bolsas de pegamento (20 kg)';

  @override
  String get mortarAdhesiveKgLabel => 'Pegamento total (kg)';

  @override
  String get mortarGroutKgLabel => 'Lechada (kg)';

  @override
  String get concreteVolumeLabel => 'Volumen (m³)';

  @override
  String get concreteMixLabel => 'Proporción (cemento:arena:grava)';

  @override
  String get concreteWcRatioLabel => 'Relación agua/cemento (a/c)';

  @override
  String get concreteMixStructural => '1 : 2 : 3 — estructural (≈ 20 MPa)';

  @override
  String get concreteMixFloor => '1 : 3 : 4 — contrapiso (≈ 15 MPa)';

  @override
  String get concreteMixFoundation => '1 : 4 : 6 — fundación simple (≈ 10 MPa)';

  @override
  String get concreteCementBags => 'Bolsas de cemento de 50 kg';

  @override
  String get concreteCementKg => 'Cemento (kg)';

  @override
  String get concreteSand => 'Arena (m³)';

  @override
  String get concreteGravel => 'Grava (m³)';

  @override
  String get concreteWater => 'Agua (L)';

  @override
  String get stairsHeightLabel => 'Altura piso a piso (cm)';

  @override
  String get stairsLengthLabel => 'Vano disponible (cm) — opcional';

  @override
  String get stairsSteps => 'Número de escalones';

  @override
  String get stairsRiser => 'Contrahuella (cm)';

  @override
  String get stairsTread => 'Huella (cm)';

  @override
  String get stairsTotalLength => 'Largo total (cm)';

  @override
  String get stairsComfortable => 'Dentro del rango de confort (Blondel)';

  @override
  String get stairsNotComfortable =>
      'Fuera del rango — ajusta altura o número de escalones';

  @override
  String get levelInstructions =>
      'Apoya el teléfono sobre la superficie a verificar.';

  @override
  String get levelTiltX => 'Inclinación lateral';

  @override
  String get levelTiltY => 'Inclinación frontal';

  @override
  String get compassHeading => 'Dirección';

  @override
  String get compassNorth => 'N';

  @override
  String get compassEast => 'E';

  @override
  String get compassSouth => 'S';

  @override
  String get compassWest => 'O';

  @override
  String get compassUnavailable => 'Brújula no disponible en este dispositivo.';

  @override
  String get flashlightOn => 'Encender';

  @override
  String get flashlightOff => 'Apagar';

  @override
  String get flashlightUnavailable =>
      'Linterna no disponible en este dispositivo.';

  @override
  String get validatorPositive => 'Ingrese un valor mayor que cero';

  @override
  String get validatorPositiveInt => 'Ingrese un entero mayor que cero';
}
