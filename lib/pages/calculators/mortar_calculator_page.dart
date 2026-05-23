import 'package:floor_calculator/features/mortar/mortar_calculator.dart';
import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/calc_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MortarCalculatorPage extends StatefulWidget {
  const MortarCalculatorPage({super.key});

  @override
  State<MortarCalculatorPage> createState() => _MortarCalculatorPageState();
}

class _MortarCalculatorPageState extends State<MortarCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _area = 0;
  double _tileWidth = 60;
  double _tileLength = 60;
  double _joint = 2;
  MortarResult? _result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CalcScaffold(
      title: l10n.mortarCalculatorTile,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _field(
                label: l10n.mortarAreaLabel,
                onSaved: (v) => _area = ParseHelper.toDouble(v),
                l10n: l10n,
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: _field(
                    label: l10n.mortarTileWidthLabel,
                    initialValue: '60',
                    onSaved: (v) => _tileWidth = ParseHelper.toDouble(v),
                    l10n: l10n,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    label: l10n.mortarTileLengthLabel,
                    initialValue: '60',
                    onSaved: (v) => _tileLength = ParseHelper.toDouble(v),
                    l10n: l10n,
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              _field(
                label: l10n.mortarJointLabel,
                initialValue: '2',
                onSaved: (v) => _joint = ParseHelper.toDouble(v),
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
                    (l10n.mortarBagsLabel, '${_result!.adhesiveBags20kg}'),
                    (
                      l10n.mortarAdhesiveKgLabel,
                      _result!.adhesiveKg.toStringAsFixed(1),
                    ),
                    (
                      l10n.mortarGroutKgLabel,
                      _result!.groutKg.toStringAsFixed(2),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    String? initialValue,
    required void Function(String?) onSaved,
    required AppLocalizations l10n,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
      validator: (v) =>
          ParseHelper.toDouble(v) > 0 ? null : l10n.validatorPositive,
      onSaved: onSaved,
    );
  }

  void _calculate() {
    final state = _formKey.currentState;
    if (state == null || !state.validate()) return;
    state.save();
    setState(() {
      _result = MortarCalculator.calculate(
        MortarInput(
          areaM2: _area,
          tileWidthCm: _tileWidth,
          tileLengthCm: _tileLength,
          jointWidthMm: _joint,
        ),
      );
    });
  }
}
