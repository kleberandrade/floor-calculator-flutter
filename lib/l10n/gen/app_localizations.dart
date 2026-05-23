import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Calculadora de Pisos'**
  String get appTitle;

  /// No description provided for @calculatorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Calculadora de pisos'**
  String get calculatorTitle;

  /// No description provided for @resultTitle.
  ///
  /// In pt, this message translates to:
  /// **'Resultado'**
  String get resultTitle;

  /// No description provided for @floorDimensionsSection.
  ///
  /// In pt, this message translates to:
  /// **'Dimensões do piso'**
  String get floorDimensionsSection;

  /// No description provided for @roomsSection.
  ///
  /// In pt, this message translates to:
  /// **'Cômodos'**
  String get roomsSection;

  /// No description provided for @wastageLabel.
  ///
  /// In pt, this message translates to:
  /// **'Margem de perda: {percent}%'**
  String wastageLabel(String percent);

  /// No description provided for @floorWidthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Largura (cm)'**
  String get floorWidthLabel;

  /// No description provided for @floorLengthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Comprimento (cm)'**
  String get floorLengthLabel;

  /// No description provided for @pricePerBoxLabel.
  ///
  /// In pt, this message translates to:
  /// **'Preço por caixa (R\$)'**
  String get pricePerBoxLabel;

  /// No description provided for @piecesPerBoxLabel.
  ///
  /// In pt, this message translates to:
  /// **'Pisos por caixa'**
  String get piecesPerBoxLabel;

  /// No description provided for @roomNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome do cômodo'**
  String get roomNameLabel;

  /// No description provided for @roomWidthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Largura (m)'**
  String get roomWidthLabel;

  /// No description provided for @roomLengthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Comprimento (m)'**
  String get roomLengthLabel;

  /// No description provided for @addRoom.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar cômodo'**
  String get addRoom;

  /// No description provided for @removeRoom.
  ///
  /// In pt, this message translates to:
  /// **'Remover cômodo'**
  String get removeRoom;

  /// No description provided for @calculateButton.
  ///
  /// In pt, this message translates to:
  /// **'CALCULAR'**
  String get calculateButton;

  /// No description provided for @shareButton.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get shareButton;

  /// No description provided for @continueButton.
  ///
  /// In pt, this message translates to:
  /// **'CONTINUAR'**
  String get continueButton;

  /// No description provided for @clearFormTooltip.
  ///
  /// In pt, this message translates to:
  /// **'Limpar campos'**
  String get clearFormTooltip;

  /// No description provided for @clearedToast.
  ///
  /// In pt, this message translates to:
  /// **'Formulário limpo'**
  String get clearedToast;

  /// No description provided for @calculateSuccessToast.
  ///
  /// In pt, this message translates to:
  /// **'Cálculo realizado'**
  String get calculateSuccessToast;

  /// No description provided for @calculateErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Verifique os campos do formulário'**
  String get calculateErrorTitle;

  /// No description provided for @calculateErrorDesc.
  ///
  /// In pt, this message translates to:
  /// **'Há valores inválidos ou faltando para calcular.'**
  String get calculateErrorDesc;

  /// No description provided for @shareDoneToast.
  ///
  /// In pt, this message translates to:
  /// **'Orçamento compartilhado'**
  String get shareDoneToast;

  /// No description provided for @noResultEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum cálculo realizado.'**
  String get noResultEmpty;

  /// No description provided for @quantitiesSection.
  ///
  /// In pt, this message translates to:
  /// **'Quantidades'**
  String get quantitiesSection;

  /// No description provided for @areasSection.
  ///
  /// In pt, this message translates to:
  /// **'Áreas'**
  String get areasSection;

  /// No description provided for @costSection.
  ///
  /// In pt, this message translates to:
  /// **'Custo'**
  String get costSection;

  /// No description provided for @perRoomSection.
  ///
  /// In pt, this message translates to:
  /// **'Por cômodo'**
  String get perRoomSection;

  /// No description provided for @floorPiecesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade de pisos no chão'**
  String get floorPiecesLabel;

  /// No description provided for @footerPiecesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade de pisos para o rodapé'**
  String get footerPiecesLabel;

  /// No description provided for @totalPiecesNoWastageLabel.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade total (sem perda)'**
  String get totalPiecesNoWastageLabel;

  /// No description provided for @totalPiecesWithWastageLabel.
  ///
  /// In pt, this message translates to:
  /// **'Total com {percent}% de perda'**
  String totalPiecesWithWastageLabel(String percent);

  /// No description provided for @areaWithoutFooterLabel.
  ///
  /// In pt, this message translates to:
  /// **'Metragem quadrada sem rodapé'**
  String get areaWithoutFooterLabel;

  /// No description provided for @areaWithFooterLabel.
  ///
  /// In pt, this message translates to:
  /// **'Metragem quadrada com rodapé'**
  String get areaWithFooterLabel;

  /// No description provided for @boxesLabel.
  ///
  /// In pt, this message translates to:
  /// **'{count} caixas'**
  String boxesLabel(int count);

  /// No description provided for @piecesPerBoxFootnote.
  ///
  /// In pt, this message translates to:
  /// **'{count} pisos por caixa'**
  String piecesPerBoxFootnote(int count);

  /// No description provided for @piecesUnit.
  ///
  /// In pt, this message translates to:
  /// **'{count} pisos'**
  String piecesUnit(int count);

  /// No description provided for @totalCostLabel.
  ///
  /// In pt, this message translates to:
  /// **'Custo total estimado'**
  String get totalCostLabel;

  /// No description provided for @perRoomTileSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'{name} — {area} m²'**
  String perRoomTileSubtitle(String name, String area);

  /// No description provided for @validatorFloorWidth.
  ///
  /// In pt, this message translates to:
  /// **'Informe a largura (cm) maior que zero'**
  String get validatorFloorWidth;

  /// No description provided for @validatorFloorLength.
  ///
  /// In pt, this message translates to:
  /// **'Informe o comprimento (cm) maior que zero'**
  String get validatorFloorLength;

  /// No description provided for @validatorPricePerBox.
  ///
  /// In pt, this message translates to:
  /// **'Informe o preço por caixa maior que zero'**
  String get validatorPricePerBox;

  /// No description provided for @validatorPiecesPerBox.
  ///
  /// In pt, this message translates to:
  /// **'Informe quantos pisos vêm na caixa'**
  String get validatorPiecesPerBox;

  /// No description provided for @validatorRoomWidth.
  ///
  /// In pt, this message translates to:
  /// **'Informe a largura (m) maior que zero'**
  String get validatorRoomWidth;

  /// No description provided for @validatorRoomLength.
  ///
  /// In pt, this message translates to:
  /// **'Informe o comprimento (m) maior que zero'**
  String get validatorRoomLength;

  /// No description provided for @defaultRoomName.
  ///
  /// In pt, this message translates to:
  /// **'Cômodo {index}'**
  String defaultRoomName(int index);

  /// No description provided for @themeMenuTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get themeMenuTitle;

  /// No description provided for @themeLight.
  ///
  /// In pt, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In pt, this message translates to:
  /// **'Escuro'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In pt, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @languageMenuTitle.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get languageMenuTitle;

  /// No description provided for @languagePortuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get languagePortuguese;

  /// No description provided for @languageEnglish.
  ///
  /// In pt, this message translates to:
  /// **'Inglês'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In pt, this message translates to:
  /// **'Espanhol'**
  String get languageSpanish;

  /// No description provided for @shareBudgetTitle.
  ///
  /// In pt, this message translates to:
  /// **'Orçamento de piso'**
  String get shareBudgetTitle;

  /// No description provided for @shareFloorLine.
  ///
  /// In pt, this message translates to:
  /// **'Piso: {w} x {l} cm'**
  String shareFloorLine(String w, String l);

  /// No description provided for @shareWastageLine.
  ///
  /// In pt, this message translates to:
  /// **'Perda considerada: {percent}%'**
  String shareWastageLine(String percent);

  /// No description provided for @shareRoomsHeader.
  ///
  /// In pt, this message translates to:
  /// **'Cômodos:'**
  String get shareRoomsHeader;

  /// No description provided for @shareRoomLine.
  ///
  /// In pt, this message translates to:
  /// **'- {name}: {area} m² ({pieces} pisos)'**
  String shareRoomLine(String name, String area, int pieces);

  /// No description provided for @shareSummaryHeader.
  ///
  /// In pt, this message translates to:
  /// **'Resumo:'**
  String get shareSummaryHeader;

  /// No description provided for @shareFloorPieces.
  ///
  /// In pt, this message translates to:
  /// **'- Pisos no chão: {count}'**
  String shareFloorPieces(int count);

  /// No description provided for @shareFooterPieces.
  ///
  /// In pt, this message translates to:
  /// **'- Pisos para rodapé: {count}'**
  String shareFooterPieces(int count);

  /// No description provided for @shareTotalWithWastage.
  ///
  /// In pt, this message translates to:
  /// **'- Total com perda: {count} pisos'**
  String shareTotalWithWastage(int count);

  /// No description provided for @shareTotalArea.
  ///
  /// In pt, this message translates to:
  /// **'- Área total: {area} m²'**
  String shareTotalArea(String area);

  /// No description provided for @shareBoxes.
  ///
  /// In pt, this message translates to:
  /// **'- Caixas necessárias: {count}'**
  String shareBoxes(int count);

  /// No description provided for @shareCost.
  ///
  /// In pt, this message translates to:
  /// **'- Custo total: R\$ {value}'**
  String shareCost(String value);

  /// No description provided for @homeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Calculadora de Obra'**
  String get homeTitle;

  /// No description provided for @calculatorsSection.
  ///
  /// In pt, this message translates to:
  /// **'Calculadoras'**
  String get calculatorsSection;

  /// No description provided for @toolsSection.
  ///
  /// In pt, this message translates to:
  /// **'Ferramentas'**
  String get toolsSection;

  /// No description provided for @floorCalculatorTile.
  ///
  /// In pt, this message translates to:
  /// **'Pisos'**
  String get floorCalculatorTile;

  /// No description provided for @paintCalculatorTile.
  ///
  /// In pt, this message translates to:
  /// **'Tinta'**
  String get paintCalculatorTile;

  /// No description provided for @mortarCalculatorTile.
  ///
  /// In pt, this message translates to:
  /// **'Argamassa e rejunte'**
  String get mortarCalculatorTile;

  /// No description provided for @concreteCalculatorTile.
  ///
  /// In pt, this message translates to:
  /// **'Concreto'**
  String get concreteCalculatorTile;

  /// No description provided for @stairsCalculatorTile.
  ///
  /// In pt, this message translates to:
  /// **'Escada'**
  String get stairsCalculatorTile;

  /// No description provided for @levelToolTile.
  ///
  /// In pt, this message translates to:
  /// **'Nível'**
  String get levelToolTile;

  /// No description provided for @compassToolTile.
  ///
  /// In pt, this message translates to:
  /// **'Bússola'**
  String get compassToolTile;

  /// No description provided for @flashlightToolTile.
  ///
  /// In pt, this message translates to:
  /// **'Lanterna'**
  String get flashlightToolTile;

  /// No description provided for @calculateAction.
  ///
  /// In pt, this message translates to:
  /// **'CALCULAR'**
  String get calculateAction;

  /// No description provided for @resultLabel.
  ///
  /// In pt, this message translates to:
  /// **'Resultado'**
  String get resultLabel;

  /// No description provided for @paintAreaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Área a pintar (m²)'**
  String get paintAreaLabel;

  /// No description provided for @paintCoatsLabel.
  ///
  /// In pt, this message translates to:
  /// **'Demãos'**
  String get paintCoatsLabel;

  /// No description provided for @paintYieldLabel.
  ///
  /// In pt, this message translates to:
  /// **'Rendimento (m²/L)'**
  String get paintYieldLabel;

  /// No description provided for @paintYieldHint.
  ///
  /// In pt, this message translates to:
  /// **'Padrão: 10 m²/L (uma demão de látex)'**
  String get paintYieldHint;

  /// No description provided for @paintTotalLiters.
  ///
  /// In pt, this message translates to:
  /// **'Total de tinta'**
  String get paintTotalLiters;

  /// No description provided for @paintCans18L.
  ///
  /// In pt, this message translates to:
  /// **'Latas de 18 L'**
  String get paintCans18L;

  /// No description provided for @paintCans3_6L.
  ///
  /// In pt, this message translates to:
  /// **'Galões de 3,6 L'**
  String get paintCans3_6L;

  /// No description provided for @paintLitersUnit.
  ///
  /// In pt, this message translates to:
  /// **'{value} L'**
  String paintLitersUnit(String value);

  /// No description provided for @mortarAreaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Área a assentar (m²)'**
  String get mortarAreaLabel;

  /// No description provided for @mortarTileWidthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Largura do piso (cm)'**
  String get mortarTileWidthLabel;

  /// No description provided for @mortarTileLengthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Comprimento do piso (cm)'**
  String get mortarTileLengthLabel;

  /// No description provided for @mortarJointLabel.
  ///
  /// In pt, this message translates to:
  /// **'Largura da junta (mm)'**
  String get mortarJointLabel;

  /// No description provided for @mortarBagsLabel.
  ///
  /// In pt, this message translates to:
  /// **'Sacos de argamassa colante (20 kg)'**
  String get mortarBagsLabel;

  /// No description provided for @mortarAdhesiveKgLabel.
  ///
  /// In pt, this message translates to:
  /// **'Argamassa total (kg)'**
  String get mortarAdhesiveKgLabel;

  /// No description provided for @mortarGroutKgLabel.
  ///
  /// In pt, this message translates to:
  /// **'Rejunte (kg)'**
  String get mortarGroutKgLabel;

  /// No description provided for @concreteVolumeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Volume a concretar (m³)'**
  String get concreteVolumeLabel;

  /// No description provided for @concreteMixLabel.
  ///
  /// In pt, this message translates to:
  /// **'Traço (cimento:areia:brita)'**
  String get concreteMixLabel;

  /// No description provided for @concreteWcRatioLabel.
  ///
  /// In pt, this message translates to:
  /// **'Fator água/cimento (a/c)'**
  String get concreteWcRatioLabel;

  /// No description provided for @concreteMixStructural.
  ///
  /// In pt, this message translates to:
  /// **'1 : 2 : 3 — estrutural (≈ 20 MPa)'**
  String get concreteMixStructural;

  /// No description provided for @concreteMixFloor.
  ///
  /// In pt, this message translates to:
  /// **'1 : 3 : 4 — contrapiso (≈ 15 MPa)'**
  String get concreteMixFloor;

  /// No description provided for @concreteMixFoundation.
  ///
  /// In pt, this message translates to:
  /// **'1 : 4 : 6 — fundação simples (≈ 10 MPa)'**
  String get concreteMixFoundation;

  /// No description provided for @concreteCementBags.
  ///
  /// In pt, this message translates to:
  /// **'Sacos de cimento de 50 kg'**
  String get concreteCementBags;

  /// No description provided for @concreteCementKg.
  ///
  /// In pt, this message translates to:
  /// **'Cimento (kg)'**
  String get concreteCementKg;

  /// No description provided for @concreteSand.
  ///
  /// In pt, this message translates to:
  /// **'Areia (m³)'**
  String get concreteSand;

  /// No description provided for @concreteGravel.
  ///
  /// In pt, this message translates to:
  /// **'Brita (m³)'**
  String get concreteGravel;

  /// No description provided for @concreteWater.
  ///
  /// In pt, this message translates to:
  /// **'Água (L)'**
  String get concreteWater;

  /// No description provided for @stairsHeightLabel.
  ///
  /// In pt, this message translates to:
  /// **'Altura piso a piso (cm)'**
  String get stairsHeightLabel;

  /// No description provided for @stairsLengthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Vão disponível (cm) — opcional'**
  String get stairsLengthLabel;

  /// No description provided for @stairsSteps.
  ///
  /// In pt, this message translates to:
  /// **'Número de degraus'**
  String get stairsSteps;

  /// No description provided for @stairsRiser.
  ///
  /// In pt, this message translates to:
  /// **'Espelho (cm)'**
  String get stairsRiser;

  /// No description provided for @stairsTread.
  ///
  /// In pt, this message translates to:
  /// **'Piso do degrau (cm)'**
  String get stairsTread;

  /// No description provided for @stairsTotalLength.
  ///
  /// In pt, this message translates to:
  /// **'Comprimento total (cm)'**
  String get stairsTotalLength;

  /// No description provided for @stairsComfortable.
  ///
  /// In pt, this message translates to:
  /// **'Dimensionamento dentro do conforto (Blondel)'**
  String get stairsComfortable;

  /// No description provided for @stairsNotComfortable.
  ///
  /// In pt, this message translates to:
  /// **'Fora da faixa de conforto — ajuste a altura ou o número de degraus'**
  String get stairsNotComfortable;

  /// No description provided for @levelInstructions.
  ///
  /// In pt, this message translates to:
  /// **'Apoie o celular sobre a superfície a verificar.'**
  String get levelInstructions;

  /// No description provided for @levelTiltX.
  ///
  /// In pt, this message translates to:
  /// **'Inclinação lateral'**
  String get levelTiltX;

  /// No description provided for @levelTiltY.
  ///
  /// In pt, this message translates to:
  /// **'Inclinação frontal'**
  String get levelTiltY;

  /// No description provided for @compassHeading.
  ///
  /// In pt, this message translates to:
  /// **'Direção'**
  String get compassHeading;

  /// No description provided for @compassNorth.
  ///
  /// In pt, this message translates to:
  /// **'N'**
  String get compassNorth;

  /// No description provided for @compassEast.
  ///
  /// In pt, this message translates to:
  /// **'L'**
  String get compassEast;

  /// No description provided for @compassSouth.
  ///
  /// In pt, this message translates to:
  /// **'S'**
  String get compassSouth;

  /// No description provided for @compassWest.
  ///
  /// In pt, this message translates to:
  /// **'O'**
  String get compassWest;

  /// No description provided for @compassUnavailable.
  ///
  /// In pt, this message translates to:
  /// **'Bússola indisponível neste aparelho.'**
  String get compassUnavailable;

  /// No description provided for @flashlightOn.
  ///
  /// In pt, this message translates to:
  /// **'Acender'**
  String get flashlightOn;

  /// No description provided for @flashlightOff.
  ///
  /// In pt, this message translates to:
  /// **'Apagar'**
  String get flashlightOff;

  /// No description provided for @flashlightUnavailable.
  ///
  /// In pt, this message translates to:
  /// **'Lanterna indisponível neste aparelho.'**
  String get flashlightUnavailable;

  /// No description provided for @validatorPositive.
  ///
  /// In pt, this message translates to:
  /// **'Informe um valor maior que zero'**
  String get validatorPositive;

  /// No description provided for @validatorPositiveInt.
  ///
  /// In pt, this message translates to:
  /// **'Informe um inteiro maior que zero'**
  String get validatorPositiveInt;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
