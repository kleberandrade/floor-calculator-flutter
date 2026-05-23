import 'package:floor_calculator/features/concrete/concrete_calculator.dart';
import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/calc_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConcreteCalculatorPage extends StatefulWidget {
  const ConcreteCalculatorPage({super.key});

  @override
  State<ConcreteCalculatorPage> createState() => _ConcreteCalculatorPageState();
}

class _ConcreteCalculatorPageState extends State<ConcreteCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _volume = 0;
  ConcreteMix _mix = ConcreteMix.m20Structural;
  double _wc = 0.5;
  ConcreteResult? _result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CalcScaffold(
      title: l10n.concreteCalculatorTile,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _field(
                label: l10n.concreteVolumeLabel,
                onSaved: (v) => _volume = ParseHelper.toDouble(v),
                l10n: l10n,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ConcreteMix>(
                isExpanded: true,
                initialValue: _mix,
                decoration: InputDecoration(
                  labelText: l10n.concreteMixLabel,
                ),
                items: [
                  DropdownMenuItem(
                    value: ConcreteMix.m20Structural,
                    child: Text(
                      l10n.concreteMixStructural,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ConcreteMix.m15Floor,
                    child: Text(
                      l10n.concreteMixFloor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ConcreteMix.m10Foundation,
                    child: Text(
                      l10n.concreteMixFoundation,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _mix = v ?? _mix),
              ),
              const SizedBox(height: 12),
              _field(
                label: l10n.concreteWcRatioLabel,
                initialValue: '0.5',
                onSaved: (v) => _wc = ParseHelper.toDouble(v),
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
                    (l10n.concreteCementBags, '${_result!.cementBags50kg}'),
                    (l10n.concreteCementKg, _result!.cementKg.toStringAsFixed(1)),
                    (l10n.concreteSand, _result!.sandM3.toStringAsFixed(2)),
                    (l10n.concreteGravel, _result!.gravelM3.toStringAsFixed(2)),
                    (l10n.concreteWater, _result!.waterLiters.toStringAsFixed(0)),
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
      _result = ConcreteCalculator.calculate(
        ConcreteInput(
          volumeM3: _volume,
          mix: _mix,
          waterCementRatio: _wc,
        ),
      );
    });
  }
}
