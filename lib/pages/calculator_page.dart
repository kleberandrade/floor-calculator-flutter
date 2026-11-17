import 'package:material_ui/material_ui.dart';
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
