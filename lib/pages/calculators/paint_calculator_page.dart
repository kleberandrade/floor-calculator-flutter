import 'package:floor_calculator/features/paint/paint_calculator.dart';
import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/calc_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaintCalculatorPage extends StatefulWidget {
  const PaintCalculatorPage({super.key});

  @override
  State<PaintCalculatorPage> createState() => _PaintCalculatorPageState();
}

class _PaintCalculatorPageState extends State<PaintCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _area = 0;
  int _coats = 2;
  double _yield = 10;
  PaintResult? _result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CalcScaffold(
      title: l10n.paintCalculatorTile,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _doubleField(
                label: l10n.paintAreaLabel,
                onSaved: (v) => _area = ParseHelper.toDouble(v),
                l10n: l10n,
              ),
              const SizedBox(height: 12),
              _intField(
                label: l10n.paintCoatsLabel,
                initialValue: '2',
                onSaved: (v) => _coats = int.tryParse(v ?? '') ?? 0,
                l10n: l10n,
              ),
              const SizedBox(height: 12),
              _doubleField(
                label: l10n.paintYieldLabel,
                helper: l10n.paintYieldHint,
                initialValue: '10',
                onSaved: (v) => _yield = ParseHelper.toDouble(v),
                l10n: l10n,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculate,
                child: Text(l10n.calculateAction),
              ),
              if (_result != null) ...[
                const SizedBox(height: 24),
                ResultCard(
                  title: l10n.resultLabel,
                  items: [
                    (
                      l10n.paintTotalLiters,
                      l10n.paintLitersUnit(_result!.totalLiters.toStringAsFixed(2))
                    ),
                    (l10n.paintCans18L, '${_result!.cans18L}'),
                    (l10n.paintCans3_6L, '${_result!.cans3_6L}'),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _doubleField({
    required String label,
    String? helper,
    String? initialValue,
    required void Function(String?) onSaved,
    required AppLocalizations l10n,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label, helperText: helper),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
      validator: (v) =>
          ParseHelper.toDouble(v) > 0 ? null : l10n.validatorPositive,
      onSaved: onSaved,
    );
  }

  Widget _intField({
    required String label,
    String? initialValue,
    required void Function(String?) onSaved,
    required AppLocalizations l10n,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (v) {
        final n = int.tryParse((v ?? '').trim()) ?? 0;
        return n > 0 ? null : l10n.validatorPositiveInt;
      },
      onSaved: onSaved,
    );
  }

  void _calculate() {
    final state = _formKey.currentState;
    if (state == null || !state.validate()) return;
    state.save();
    setState(() {
      _result = PaintCalculator.calculate(
        PaintInput(areaM2: _area, coats: _coats, yieldM2PerLiter: _yield),
      );
    });
  }
}
