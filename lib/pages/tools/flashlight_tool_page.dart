import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/calc_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightToolPage extends StatefulWidget {
  const FlashlightToolPage({super.key});

  @override
  State<FlashlightToolPage> createState() => _FlashlightToolPageState();
}

class _FlashlightToolPageState extends State<FlashlightToolPage> {
  bool _on = false;
  bool _unavailable = false;

  @override
  void dispose() {
    if (_on) TorchLight.disableTorch().catchError((_) {});
    super.dispose();
  }

  Future<void> _toggle() async {
    try {
      if (_on) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      if (mounted) setState(() => _on = !_on);
    } catch (_) {
      if (mounted) setState(() => _unavailable = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    return CalcScaffold(
      title: l10n.flashlightToolTile,
      body: Center(
        child: _unavailable
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  l10n.flashlightUnavailable,
                  textAlign: TextAlign.center,
                ),
              )
            : GestureDetector(
                onTap: _toggle,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _on
                        ? colors.primary
                        : colors.surfaceContainerHighest,
                    boxShadow: _on
                        ? [
                            BoxShadow(
                              color: colors.primary.withValues(alpha: 0.5),
                              blurRadius: 60,
                              spreadRadius: 10,
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _on ? Icons.flashlight_on : Icons.flashlight_off,
                        size: 80,
                        color: _on ? colors.onPrimary : colors.onSurface,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _on ? l10n.flashlightOff : l10n.flashlightOn,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _on ? colors.onPrimary : colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
