import 'package:floor_calculator/features/stairs/stairs_calculator.dart';
import 'package:floor_calculator/helpers/parse_helper.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/calc_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StairsCalculatorPage extends StatefulWidget {
  const StairsCalculatorPage({super.key});

  @override
  State<StairsCalculatorPage> createState() => _StairsCalculatorPageState();
}

class _StairsCalculatorPageState extends State<StairsCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _height = 0;
  StairsResult? _result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CalcScaffold(
      title: l10n.stairsCalculatorTile,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _field(
                label: l10n.stairsHeightLabel,
                onSaved: (v) => _height = ParseHelper.toDouble(v),
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
                    (l10n.stairsSteps, '${_result!.numberOfSteps}'),
                    (l10n.stairsRiser, _result!.riserCm.toStringAsFixed(1)),
                    (l10n.stairsTread, _result!.treadCm.toStringAsFixed(1)),
                    (l10n.stairsTotalLength, _result!.totalLengthCm.toStringAsFixed(1)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      _result!.comfortable ? Icons.check_circle : Icons.warning,
                      color: _result!.comfortable
                          ? Colors.green
                          : Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _result!.comfortable
                            ? l10n.stairsComfortable
                            : l10n.stairsNotComfortable,
                        style: TextStyle(
                          color: _result!.comfortable
                              ? Colors.green
                              : Theme.of(context).colorScheme.error,
                        ),
                      ),
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
    required void Function(String?) onSaved,
    required AppLocalizations l10n,
  }) {
    return TextFormField(
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
      _result = StairsCalculator.calculate(
        StairsInput(totalHeightCm: _height),
      );
    });
  }
}
