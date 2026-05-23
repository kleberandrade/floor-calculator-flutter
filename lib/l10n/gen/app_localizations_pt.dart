// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Calculadora de Pisos';

  @override
  String get calculatorTitle => 'Calculadora de pisos';

  @override
  String get resultTitle => 'Resultado';

  @override
  String get floorDimensionsSection => 'Dimensões do piso';

  @override
  String get roomsSection => 'Cômodos';

  @override
  String wastageLabel(String percent) {
    return 'Margem de perda: $percent%';
  }

  @override
  String get floorWidthLabel => 'Largura (cm)';

  @override
  String get floorLengthLabel => 'Comprimento (cm)';

  @override
  String get pricePerBoxLabel => 'Preço por caixa (R\$)';

  @override
  String get piecesPerBoxLabel => 'Pisos por caixa';

  @override
  String get roomNameLabel => 'Nome do cômodo';

  @override
  String get roomWidthLabel => 'Largura (m)';

  @override
  String get roomLengthLabel => 'Comprimento (m)';

  @override
  String get addRoom => 'Adicionar cômodo';

  @override
  String get removeRoom => 'Remover cômodo';

  @override
  String get calculateButton => 'CALCULAR';

  @override
  String get shareButton => 'Compartilhar';

  @override
  String get continueButton => 'CONTINUAR';

  @override
  String get clearFormTooltip => 'Limpar campos';

  @override
  String get clearedToast => 'Formulário limpo';

  @override
  String get calculateSuccessToast => 'Cálculo realizado';

  @override
  String get calculateErrorTitle => 'Verifique os campos do formulário';

  @override
  String get calculateErrorDesc =>
      'Há valores inválidos ou faltando para calcular.';

  @override
  String get shareDoneToast => 'Orçamento compartilhado';

  @override
  String get noResultEmpty => 'Nenhum cálculo realizado.';

  @override
  String get quantitiesSection => 'Quantidades';

  @override
  String get areasSection => 'Áreas';

  @override
  String get costSection => 'Custo';

  @override
  String get perRoomSection => 'Por cômodo';

  @override
  String get floorPiecesLabel => 'Quantidade de pisos no chão';

  @override
  String get footerPiecesLabel => 'Quantidade de pisos para o rodapé';

  @override
  String get totalPiecesNoWastageLabel => 'Quantidade total (sem perda)';

  @override
  String totalPiecesWithWastageLabel(String percent) {
    return 'Total com $percent% de perda';
  }

  @override
  String get areaWithoutFooterLabel => 'Metragem quadrada sem rodapé';

  @override
  String get areaWithFooterLabel => 'Metragem quadrada com rodapé';

  @override
  String boxesLabel(int count) {
    return '$count caixas';
  }

  @override
  String piecesPerBoxFootnote(int count) {
    return '$count pisos por caixa';
  }

  @override
  String piecesUnit(int count) {
    return '$count pisos';
  }

  @override
  String get totalCostLabel => 'Custo total estimado';

  @override
  String perRoomTileSubtitle(String name, String area) {
    return '$name — $area m²';
  }

  @override
  String get validatorFloorWidth => 'Informe a largura (cm) maior que zero';

  @override
  String get validatorFloorLength =>
      'Informe o comprimento (cm) maior que zero';

  @override
  String get validatorPricePerBox => 'Informe o preço por caixa maior que zero';

  @override
  String get validatorPiecesPerBox => 'Informe quantos pisos vêm na caixa';

  @override
  String get validatorRoomWidth => 'Informe a largura (m) maior que zero';

  @override
  String get validatorRoomLength => 'Informe o comprimento (m) maior que zero';

  @override
  String defaultRoomName(int index) {
    return 'Cômodo $index';
  }

  @override
  String get themeMenuTitle => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get languageMenuTitle => 'Idioma';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get shareBudgetTitle => 'Orçamento de piso';

  @override
  String shareFloorLine(String w, String l) {
    return 'Piso: $w x $l cm';
  }

  @override
  String shareWastageLine(String percent) {
    return 'Perda considerada: $percent%';
  }

  @override
  String get shareRoomsHeader => 'Cômodos:';

  @override
  String shareRoomLine(String name, String area, int pieces) {
    return '- $name: $area m² ($pieces pisos)';
  }

  @override
  String get shareSummaryHeader => 'Resumo:';

  @override
  String shareFloorPieces(int count) {
    return '- Pisos no chão: $count';
  }

  @override
  String shareFooterPieces(int count) {
    return '- Pisos para rodapé: $count';
  }

  @override
  String shareTotalWithWastage(int count) {
    return '- Total com perda: $count pisos';
  }

  @override
  String shareTotalArea(String area) {
    return '- Área total: $area m²';
  }

  @override
  String shareBoxes(int count) {
    return '- Caixas necessárias: $count';
  }

  @override
  String shareCost(String value) {
    return '- Custo total: R\$ $value';
  }

  @override
  String get homeTitle => 'Calculadora de Obra';

  @override
  String get calculatorsSection => 'Calculadoras';

  @override
  String get toolsSection => 'Ferramentas';

  @override
  String get floorCalculatorTile => 'Pisos';

  @override
  String get paintCalculatorTile => 'Tinta';

  @override
  String get mortarCalculatorTile => 'Argamassa e rejunte';

  @override
  String get concreteCalculatorTile => 'Concreto';

  @override
  String get stairsCalculatorTile => 'Escada';

  @override
  String get levelToolTile => 'Nível';

  @override
  String get compassToolTile => 'Bússola';

  @override
  String get flashlightToolTile => 'Lanterna';

  @override
  String get calculateAction => 'CALCULAR';

  @override
  String get resultLabel => 'Resultado';

  @override
  String get paintAreaLabel => 'Área a pintar (m²)';

  @override
  String get paintCoatsLabel => 'Demãos';

  @override
  String get paintYieldLabel => 'Rendimento (m²/L)';

  @override
  String get paintYieldHint => 'Padrão: 10 m²/L (uma demão de látex)';

  @override
  String get paintTotalLiters => 'Total de tinta';

  @override
  String get paintCans18L => 'Latas de 18 L';

  @override
  String get paintCans3_6L => 'Galões de 3,6 L';

  @override
  String paintLitersUnit(String value) {
    return '$value L';
  }

  @override
  String get mortarAreaLabel => 'Área a assentar (m²)';

  @override
  String get mortarTileWidthLabel => 'Largura do piso (cm)';

  @override
  String get mortarTileLengthLabel => 'Comprimento do piso (cm)';

  @override
  String get mortarJointLabel => 'Largura da junta (mm)';

  @override
  String get mortarBagsLabel => 'Sacos de argamassa colante (20 kg)';

  @override
  String get mortarAdhesiveKgLabel => 'Argamassa total (kg)';

  @override
  String get mortarGroutKgLabel => 'Rejunte (kg)';

  @override
  String get concreteVolumeLabel => 'Volume a concretar (m³)';

  @override
  String get concreteMixLabel => 'Traço (cimento:areia:brita)';

  @override
  String get concreteWcRatioLabel => 'Fator água/cimento (a/c)';

  @override
  String get concreteMixStructural => '1 : 2 : 3 — estrutural (≈ 20 MPa)';

  @override
  String get concreteMixFloor => '1 : 3 : 4 — contrapiso (≈ 15 MPa)';

  @override
  String get concreteMixFoundation => '1 : 4 : 6 — fundação simples (≈ 10 MPa)';

  @override
  String get concreteCementBags => 'Sacos de cimento de 50 kg';

  @override
  String get concreteCementKg => 'Cimento (kg)';

  @override
  String get concreteSand => 'Areia (m³)';

  @override
  String get concreteGravel => 'Brita (m³)';

  @override
  String get concreteWater => 'Água (L)';

  @override
  String get stairsHeightLabel => 'Altura piso a piso (cm)';

  @override
  String get stairsLengthLabel => 'Vão disponível (cm) — opcional';

  @override
  String get stairsSteps => 'Número de degraus';

  @override
  String get stairsRiser => 'Espelho (cm)';

  @override
  String get stairsTread => 'Piso do degrau (cm)';

  @override
  String get stairsTotalLength => 'Comprimento total (cm)';

  @override
  String get stairsComfortable =>
      'Dimensionamento dentro do conforto (Blondel)';

  @override
  String get stairsNotComfortable =>
      'Fora da faixa de conforto — ajuste a altura ou o número de degraus';

  @override
  String get levelInstructions =>
      'Apoie o celular sobre a superfície a verificar.';

  @override
  String get levelTiltX => 'Inclinação lateral';

  @override
  String get levelTiltY => 'Inclinação frontal';

  @override
  String get compassHeading => 'Direção';

  @override
  String get compassNorth => 'N';

  @override
  String get compassEast => 'L';

  @override
  String get compassSouth => 'S';

  @override
  String get compassWest => 'O';

  @override
  String get compassUnavailable => 'Bússola indisponível neste aparelho.';

  @override
  String get flashlightOn => 'Acender';

  @override
  String get flashlightOff => 'Apagar';

  @override
  String get flashlightUnavailable => 'Lanterna indisponível neste aparelho.';

  @override
  String get validatorPositive => 'Informe um valor maior que zero';

  @override
  String get validatorPositiveInt => 'Informe um inteiro maior que zero';
}
