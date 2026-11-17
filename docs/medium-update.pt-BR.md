# Revisão do tutorial — Calculadora de pisos e revestimentos

URL original: https://medium.com/@kleberandrade/criando-um-aplicativo-em-flutter-para-calcular-a-quantidade-de-pisos-por-m%C2%B2-dac30b5b5027

Autor: Kleber de Oliveira Andrade. Idioma preservado: português.

## Situação editorial em 17/11/2026

O artigo real foi aberto e lido no Chrome: título, explicação MVC, modelos, helpers, controlador, testes, views, tema e desafios. A página mostra “Sign in”, “Sign up” e “Unknown user”; não há sessão editorial autenticada nem comando de edição. Nenhuma alteração foi publicada no Medium. Este arquivo é a revisão concreta para aplicar à mesma publicação quando houver acesso; não cria outro artigo nem altera artigos de terceiros.

Preservar título, subtítulo “Notas de aula do professor Kleber de Oliveira Andrade”, URL, introdução, vídeo do professor Aloísio Delpupo, vídeo de TDD do Código Fonte TV e links/créditos de referência. As capturas antigas e os snippets em imagens descrevem a versão de 2020: substituir esses exemplos pelos códigos abaixo e usar as capturas reais de `docs/screenshots/`. O tutorial de @suragch permanece referência externa, sem alterações.

## Texto atualizado para o corpo didático

### Preparando o projeto

Nesta revisão usamos Flutter 3.41.9 stable, com Dart 3.11.5 e null safety. O código continua em Flutter. Não há banco de dados nem autenticação: os valores vivem na tela e são perdidos ao fechar ou recarregar. Classes em memória não persistem dados em disco.

Para acompanhar o projeto pronto:

```sh
git clone https://github.com/kleberandrade/floor-calculator-flutter.git
cd floor-calculator-flutter
flutter pub get
flutter run -d chrome
```

Para iniciar um projeto de estudo do zero: `flutter create --project-name floor_calculator floor_calculator`, depois use os arquivos e dependências abaixo. Android/iOS precisam das ferramentas nativas indicadas no README; não é necessário emulador para experimentar na Web. Não use mais o limite Dart `<3.0.0`.

### Estrutura e responsabilidades

A aula original separava Model, View e Controller. Vamos manter a separação entre cálculo e apresentação, eliminando modelos mutáveis duplicados: `Estimate` recebe medidas, valida as regras e devolve um resultado imutável. A página cuida apenas dos campos, foco e estado local; o cartão apresenta o resultado; o tema define a aparência. Não é necessário acrescentar um gerenciador global de estado a uma tela independente.

- `lib/domain/estimate.dart`: números de entrada e cálculo puro, sem Flutter.
- `lib/pages/calculator_page.dart`: formulário e estado local.
- `lib/widgets/estimate_card.dart`: estado vazio, resultados e pressupostos.
- `lib/core/theme_app.dart`: tema Material 3.
- `lib/main.dart`: entrada do app.

Os antigos `RoomModel`, `FloorModel`, `ResultModel`, `CalculatorController`, `ParseHelper`, `ValidatorHelper` e `ResultDialog` deixam de ser necessários. Não misture snippets antigos com estes arquivos.

### Unidades e regra de cálculo

O ambiente é informado em metros; cada peça é informada em centímetros. Corrigimos um erro do exemplo antigo: os rótulos diziam centímetros, mas o controlador dividia os valores diretamente por metros. Uma peça de 60 cm agora deve ser digitada como **60**, e convertida para **0,60 m** apenas no domínio.

Calculamos `ceil(larguraAmbiente / larguraPeçaEmMetros)` e `ceil(comprimentoAmbiente / comprimentoPeçaEmMetros)`, depois multiplicamos colunas por fileiras. Essa paginação é reta, com orientação fixa e sem reaproveitar recortes. Não é a mesma coisa que dividir somente as áreas. Juntas, portas e paginação diagonal não são modeladas.

O rodapé da aula continua disponível como opção, desligada inicialmente. Sua regra é **colunas + fileiras peças adicionais**. É uma estimativa didática: não conhece perímetro e altura real de rodapé e não deve ser apresentada como dimensionamento de instalação.

Aplicamos depois a margem de perda (0 a 100%) e arredondamos para peças inteiras. Por último arredondamos para caixas fechadas. O cartão distingue a área real do ambiente da área comprada. Para 2,40 × 3,22 m e peças de 60 × 60 cm: 4 colunas × 6 fileiras = 24 peças. Com rodapé didático, perda zero e uma peça por caixa: 34 peças e 12,24 m². Sem rodapé, com perda de 10% e quatro peças por caixa: 27 peças necessárias, 7 caixas, 28 peças compradas e 10,08 m².

### Entradas e interação

O parser aceita vírgula ou ponto decimal, não separadores de milhar. Campos vazios, texto, NaN, infinito, zero ou valores negativos não viram silenciosamente zero. Peças por caixa deve ser inteiro positivo. Há limites para impedir estimativas acidentalmente enormes.

“Usar exemplo” carrega medidas locais reproduzíveis. “Limpar formulário” limpa estado e resultados. Ao editar uma medida, removemos a estimativa anterior. Tab/Shift+Tab navegam pelos campos; Enter no último campo calcula. Em telas estreitas o resultado fica abaixo do formulário, acessível por rolagem. O formulário e o cartão suportam ampliação de texto; mensagens de erro e resultado têm semântica acessível.

`RaisedButton` e `FlatButton` são substituídos pelos controles atuais `FilledButton`, `TextButton` e `IconButton`. `accentColor` é substituído por `ColorScheme`. Não usamos APIs antigas sem null safety. O cálculo é síncrono; não acrescentamos um carregamento fictício. A versão Web mostra uma mensagem enquanto o Flutter inicia e informa falha de inicialização.

### Arquivos completos da versão revisada

Copie cada bloco para o caminho indicado. O código abaixo é o código final do repositório, não pseudocódigo.

#### `pubspec.yaml`

```yaml
name: floor_calculator
description: Calculate floor and wall-covering quantities with explicit units and rounding.
publish_to: none
version: 2.0.0+2
environment:
  sdk: '>=3.11.0 <4.0.0'
  flutter: '>=3.41.0'
dependencies:
  cupertino_icons: ^1.0.9
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
flutter:
  uses-material-design: true
```

#### `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml
```

#### `lib/domain/estimate.dart`

```dart
/// Accept decimal comma or point, never grouping or non-finite values.
double? parseNumber(String text) {
  final normalized = text.trim().replaceAll(',', '.');
  if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(normalized)) return null;
  final value = double.tryParse(normalized);
  return value != null && value.isFinite ? value : null;
}

/// Immutable estimate for an aligned rectangular layout, without cut reuse.
class Estimate {
  const Estimate._(
    this.columns,
    this.rows,
    this.skirtingPieces,
    this.requiredPieces,
    this.boxes,
    this.purchasePieces,
    this.roomArea,
    this.tileArea,
  );

  final int columns,
      rows,
      skirtingPieces,
      requiredPieces,
      boxes,
      purchasePieces;
  final double roomArea, tileArea;
  int get floorPieces => columns * rows;
  double get purchaseArea => purchasePieces * tileArea;

  factory Estimate.calculate({
    required double roomWidth,
    required double roomLength,
    required double tileWidthCm,
    required double tileLengthCm,
    double wastePercent = 0,
    int piecesPerBox = 1,
    bool includeSkirting = false,
  }) {
    for (final value in [roomWidth, roomLength, tileWidthCm, tileLengthCm]) {
      if (!value.isFinite || value <= 0 || value > 100000) {
        throw ArgumentError(
          'Dimensions must be finite, positive and ≤ 100000.',
        );
      }
    }
    if (!wastePercent.isFinite ||
        wastePercent < 0 ||
        wastePercent > 100 ||
        piecesPerBox < 1 ||
        piecesPerBox > 10000) {
      throw ArgumentError('Invalid waste percentage or box size.');
    }
    final columns = _ceil(roomWidth / (tileWidthCm / 100));
    final rows = _ceil(roomLength / (tileLengthCm / 100));
    if (columns * rows > 10000000) {
      throw ArgumentError('Estimate exceeds ten million pieces.');
    }
    final skirting = includeSkirting ? columns + rows : 0;
    final required = _ceil(
      (columns * rows + skirting) * (1 + wastePercent / 100),
    );
    final boxes = _ceil(required / piecesPerBox);
    return Estimate._(
      columns,
      rows,
      skirting,
      required,
      boxes,
      boxes * piecesPerBox,
      roomWidth * roomLength,
      tileWidthCm * tileLengthCm / 10000,
    );
  }

  // Correct only floating point noise around an exact integer.
  static int _ceil(double value) {
    if (!value.isFinite || value > 1000000000) {
      throw ArgumentError('Estimate exceeds supported quantities.');
    }
    if (value == 0) return 1; // Positive dimensions can underflow in division.
    final rounded = value.round();
    return rounded > 0 && (value - rounded).abs() < 1e-9
        ? rounded
        : value.ceil();
  }
}
```

#### `lib/core/theme_app.dart`

```dart
import 'package:flutter/material.dart';

final themeApp = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9A452B)),
  scaffoldBackgroundColor: const Color(0xFFF7F4EF),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  ),
  cardTheme: const CardThemeData(
    color: Colors.white,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  ),
);
```

#### `lib/widgets/estimate_card.dart`

```dart
import 'package:flutter/material.dart';
import '../domain/estimate.dart';

String decimal(double value) => value.toStringAsFixed(2).replaceAll('.', ',');

class EstimateCard extends StatelessWidget {
  const EstimateCard({super.key, required this.result});
  final Estimate? result;
  @override
  Widget build(BuildContext context) {
    final value = result;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.grid_view_rounded,
              size: 36,
              color: Color(0xFF9A452B),
            ),
            const SizedBox(height: 20),
            Text(
              value == null ? 'Pronto para planejar?' : 'Sua lista de compra',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            if (value == null)
              const Text(
                'Preencha as medidas ou use o exemplo. A estimativa aparecerá aqui, com todos os arredondamentos.',
              )
            else ...[
              Semantics(
                liveRegion: true,
                child: Text(
                  '${value.purchasePieces} peças',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${value.boxes} caixas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _line('Área do ambiente', '${decimal(value.roomArea)} m²'),
              _line('Peças para o piso', '${value.floorPieces}'),
              _line('Fileiras × colunas', '${value.rows} × ${value.columns}'),
              _line('Peças para rodapé', '${value.skirtingPieces}'),
              _line('Com margem de perda', '${value.requiredPieces} peças'),
              const Divider(height: 28),
              _line('Área de compra', '${decimal(value.purchaseArea)} m²'),
            ],
            const SizedBox(height: 24),
            const Text(
              'COMO ESTIMAMOS',
              style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.2),
            ),
            const SizedBox(height: 8),
            const Text(
              'Paginação reta, sem reaproveitar recortes. Arredondamos cada dimensão para cima, depois a perda e as caixas completas. Não considera juntas, portas ou paginação diagonal.',
            ),
            const SizedBox(height: 12),
            const Text(
              'Confira as medidas e a paginação com o instalador antes de comprar.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    ),
  );
}
```

#### `lib/pages/calculator_page.dart`

```dart
import 'package:flutter/material.dart';
import '../domain/estimate.dart';
import '../widgets/estimate_card.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _form = GlobalKey<FormState>();
  final _fields = List.generate(6, (_) => TextEditingController());
  Estimate? _result;
  String? _error;
  bool _skirting = false;

  @override
  void dispose() {
    for (final field in _fields) {
      field.dispose();
    }
    super.dispose();
  }

  void _invalidate() => setState(() {
    _result = null;
    _error = null;
  });

  void _example() {
    _skirting = false;
    _form.currentState?.reset();
    const values = ['2,40', '3,22', '60', '60', '10', '4'];
    for (var i = 0; i < values.length; i++) {
      _fields[i].text = values[i];
    }
    _invalidate();
  }

  void _clear() {
    _form.currentState?.reset();
    for (final field in _fields) {
      field.clear();
    }
    setState(() {
      _result = null;
      _error = null;
      _skirting = false;
    });
  }

  void _calculate() {
    if (!(_form.currentState?.validate() ?? false)) return;
    final values = _fields.map((field) => parseNumber(field.text)!).toList();
    try {
      final result = Estimate.calculate(
        roomWidth: values[0],
        roomLength: values[1],
        tileWidthCm: values[2],
        tileLengthCm: values[3],
        wastePercent: values[4],
        piecesPerBox: values[5].toInt(),
        includeSkirting: _skirting,
      );
      setState(() {
        _result = result;
        _error = null;
      });
      FocusScope.of(context).unfocus();
    } on ArgumentError {
      setState(() {
        _result = null;
        _error = 'Quantidade muito alta. Confira as medidas e unidades.';
      });
    }
  }

  String? _validate(String? text, int index) {
    final value = parseNumber(text ?? '');
    if (value == null) return 'Informe um número válido (ex.: 2,40).';
    if (index == 4) {
      return value <= 100 ? null : 'Use uma perda entre 0 e 100%.';
    }
    if (value <= 0) return 'Informe um valor maior que zero.';
    if (index == 5 && (value != value.roundToDouble() || value > 10000)) {
      return 'Use um inteiro de 1 a 10.000.';
    }
    return value <= 100000 ? null : 'Valor máximo: 100.000.';
  }

  Widget _field(int index, String label, String unit) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: TextFormField(
      controller: _fields[index],
      decoration: InputDecoration(
        labelText: '$label ($unit)',
        suffixText: unit,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: index == 5 ? TextInputAction.done : TextInputAction.next,
      validator: (text) => _validate(text, index),
      onChanged: (_) => _invalidate(),
      onFieldSubmitted: (_) {
        if (index == 5) _calculate();
      },
    ),
  );

  Widget _section(String number, String title, List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          '$number  $title',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      ...children,
    ],
  );

  Widget _formCard() => Card(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _section('01', 'Seu ambiente', [
              _field(0, 'Largura do ambiente', 'm'),
              _field(1, 'Comprimento do ambiente', 'm'),
            ]),
            _section('02', 'Seu revestimento', [
              _field(2, 'Largura da peça', 'cm'),
              _field(3, 'Comprimento da peça', 'cm'),
            ]),
            _section('03', 'Planeje a compra', [
              _field(4, 'Margem de perda', '%'),
              _field(5, 'Peças por caixa', 'un.'),
            ]),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _skirting,
              title: const Text('Incluir rodapé didático'),
              subtitle: const Text(
                'Soma uma peça por fileira e por coluna. Não usa a altura real do rodapé.',
              ),
              onChanged: (value) {
                setState(() {
                  _skirting = value;
                });
                _invalidate();
              },
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _calculate,
              icon: const Icon(Icons.calculate_outlined),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Calcular quantidade'),
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Semantics(
                  liveRegion: true,
                  child: Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  children: [
                    const Icon(
                      Icons.view_quilt_outlined,
                      color: Color(0xFF9A452B),
                      size: 32,
                    ),
                    Text(
                      'PISO • PLANEJADOR',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(letterSpacing: 2),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Cada peça conta.',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Calcule pisos e revestimentos com medidas claras e menos surpresas na compra.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  children: [
                    TextButton.icon(
                      onPressed: _example,
                      icon: const Icon(Icons.auto_awesome_outlined),
                      label: const Text('Usar exemplo'),
                    ),
                    IconButton(
                      onPressed: _clear,
                      tooltip: 'Limpar formulário',
                      icon: const Icon(Icons.restart_alt),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 800) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _formCard(),
                          const SizedBox(height: 24),
                          EstimateCard(result: _result),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: _formCard()),
                        const SizedBox(width: 24),
                        Expanded(flex: 5, child: EstimateCard(result: _result)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Feito para aprender e planejar • Kleber de Oliveira Andrade',
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
```

#### `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'core/theme_app.dart';
import 'pages/calculator_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calculadora de pisos',
    theme: themeApp,
    home: const CalculatorPage(),
  );
}
```

#### `test/estimate_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:floor_calculator/domain/estimate.dart';

void main() {
  Estimate run({
    double width = 2.4,
    double length = 3.22,
    double tileWidth = 60,
    double tileLength = 60,
    double waste = 0,
    int perBox = 1,
    bool skirting = false,
  }) => Estimate.calculate(
    roomWidth: width,
    roomLength: length,
    tileWidthCm: tileWidth,
    tileLengthCm: tileLength,
    wastePercent: waste,
    piecesPerBox: perBox,
    includeSkirting: skirting,
  );
  test('converts centimeters and preserves row-by-row classroom example', () {
    final result = run(skirting: true);
    expect(result.columns, 4);
    expect(result.rows, 6);
    expect(result.floorPieces, 24);
    expect(result.skirtingPieces, 10);
    expect(result.requiredPieces, 34);
    expect(result.purchaseArea, closeTo(12.24, 1e-9));
    expect(result.roomArea, closeTo(7.728, 1e-9));
  });
  test('rounds waste then full boxes upward', () {
    final result = run(waste: 10, perBox: 4);
    expect(result.requiredPieces, 27);
    expect(result.boxes, 7);
    expect(result.purchasePieces, 28);
    expect(result.purchaseArea, closeTo(10.08, 1e-9));
  });
  test('does not add a phantom row for floating point multiples', () {
    expect(
      run(width: 2.1, length: 2.1, tileWidth: 30, tileLength: 30).floorPieces,
      49,
    );
  });
  test('a tiny positive room still needs one piece', () {
    expect(run(width: 1e-12, length: 1e-12).floorPieces, 1);
  });
  test('rejects invalid and impractically large quantities', () {
    for (final value in [0.0, -1.0, double.nan, double.infinity, 1e12]) {
      expect(() => run(width: value), throwsArgumentError);
      expect(() => run(tileWidth: value), throwsArgumentError);
    }
    expect(() => run(waste: -1), throwsArgumentError);
    expect(() => run(waste: 101), throwsArgumentError);
    expect(() => run(perBox: 0), throwsArgumentError);
    expect(() => run(tileWidth: 0.000001), throwsArgumentError);
    expect(() => run(tileWidth: 1e-320), throwsArgumentError);
  });
  test(
    'parses localized decimals without silently replacing invalid input',
    () {
      expect(parseNumber(' 2,40 '), 2.4);
      for (final value in ['', 'abc', 'NaN', 'Infinity', '1.000,50']) {
        expect(parseNumber(value), isNull);
      }
    },
  );
}
```

#### `test/widget_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floor_calculator/main.dart';

void main() {
  testWidgets(
    'example calculates, editing invalidates result and clear resets',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.byType(SwitchListTile));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Usar exemplo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Calcular quantidade'));
      await tester.pumpAndSettle();
      expect(find.text('28 peças'), findsOneWidget);
      expect(find.text('7 caixas'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField).first, '0');
      await tester.pumpAndSettle();
      expect(find.text('28 peças'), findsNothing);
      await tester.tap(find.text('Calcular quantidade'));
      await tester.pumpAndSettle();
      expect(find.text('Informe um valor maior que zero.'), findsOneWidget);
      await tester.tap(find.byTooltip('Limpar formulário'));
      await tester.pumpAndSettle();
      expect(find.text('Pronto para planejar?'), findsOneWidget);
      final fields = tester.widgetList<TextFormField>(
        find.byType(TextFormField),
      );
      expect(fields.every((field) => field.controller!.text.isEmpty), isTrue);
    },
  );
  testWidgets('narrow screen with large text scrolls without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Usar exemplo'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Calcular quantidade'));
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('28 peças'));
    expect(find.text('7 caixas'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('validates localized input and explains excessive quantities', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 1500);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    expect(
      find.text('Informe um número válido (ex.: 2,40).'),
      findsNWidgets(6),
    );
    await tester.tap(find.text('Usar exemplo'));
    await tester.enterText(find.byType(TextFormField).at(4), '101');
    await tester.enterText(find.byType(TextFormField).at(5), '2.5');
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    expect(find.text('Use uma perda entre 0 e 100%.'), findsOneWidget);
    expect(find.text('Use um inteiro de 1 a 10.000.'), findsOneWidget);
    await tester.tap(find.text('Usar exemplo'));
    await tester.enterText(find.byType(TextFormField).at(2), '0,000001');
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    expect(
      find.text('Quantidade muito alta. Confira as medidas e unidades.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
```

### Testando e executando

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test --coverage
flutter build web --no-wasm-dry-run
```

Os testes cobrem conversão de centímetros, exemplo original, arredondamento por dimensão, margem de perda, caixas fechadas, limites, números inválidos, dimensões muito pequenas e interação do formulário. O teste de tela confirma que editar invalida o resultado, que o exemplo desliga um rodapé ativado anteriormente e que limpar esvazia de fato todos os campos; também executa o fluxo em tela estreita com texto ampliado.

Os testes foram escritos antes da implementação correspondente e suas falhas foram observadas. A suíte foi então usada para corrigir o preenchimento do exemplo, a restauração da opção de rodapé, a limpeza real dos controladores de texto e um arredondamento que gerava zero peças para uma dimensão positiva muito pequena. O workflow do GitHub executa análise, formatação, testes e build Web. Consulte `docs/validation.md` para os resultados reais e limitações de plataformas.

### Resultado e desafios

Abra no Chrome, selecione “Usar exemplo” e “Calcular quantidade”. Confira os valores explicados acima. No celular, role até o cartão. A interface apresenta ambiente, peça e compra em seções distintas e mantém os pressupostos próximos do resultado.

Validação de negativos/zero e limpeza, antes desafios da aula, agora estão implementadas. Como exercício futuro, acrescente preço opcional por caixa com testes de arredondamento monetário ou substitua o rodapé didático por um modelo explícito de perímetro e altura. Não há orçamento de mão de obra nesta versão.

O código completo permanece no repositório original. Preserve os créditos originais e a licença MIT de Kleber de Oliveira Andrade (2020). Os artigos de outras pessoas continuam somente como referências.
