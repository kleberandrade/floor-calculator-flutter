import 'dart:async';
import 'dart:math' as math;

import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/calc_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class LevelToolPage extends StatefulWidget {
  const LevelToolPage({super.key});

  @override
  State<LevelToolPage> createState() => _LevelToolPageState();
}

class _LevelToolPageState extends State<LevelToolPage> {
  StreamSubscription<AccelerometerEvent>? _sub;
  double _tiltX = 0; // graus em torno do eixo Y (rotação lateral)
  double _tiltY = 0; // graus em torno do eixo X (rotação frente/trás)

  @override
  void initState() {
    super.initState();
    _sub = accelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 50),
    ).listen(_onEvent);
  }

  void _onEvent(AccelerometerEvent e) {
    // atan2 retorna ângulo em radianos; convertemos para graus.
    final tiltX = math.atan2(e.x, math.sqrt(e.y * e.y + e.z * e.z)) * 180 / math.pi;
    final tiltY = math.atan2(e.y, math.sqrt(e.x * e.x + e.z * e.z)) * 180 / math.pi;
    if (mounted) {
      setState(() {
        _tiltX = tiltX;
        _tiltY = tiltY;
      });
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final isLevel = _tiltX.abs() < 1.5 && _tiltY.abs() < 1.5;

    return CalcScaffold(
      title: l10n.levelToolTile,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.levelInstructions,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _Bubble(
                    tiltX: _tiltX,
                    tiltY: _tiltY,
                    color: isLevel ? Colors.green : colors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _AngleRow(label: l10n.levelTiltX, value: _tiltX),
            const SizedBox(height: 8),
            _AngleRow(label: l10n.levelTiltY, value: _tiltY),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final double tiltX;
  final double tiltY;
  final Color color;

  const _Bubble({
    required this.tiltX,
    required this.tiltY,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final size = math.min(c.maxWidth, c.maxHeight);
        // Mapeia ±30° -> deslocamento total no círculo
        final dx = (-tiltX / 30).clamp(-1.0, 1.0) * (size / 2 - 40);
        final dy = (tiltY / 30).clamp(-1.0, 1.0) * (size / 2 - 40);
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
            ),
            // Crosshair central
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                ),
              ),
            ),
            // Bolha
            Transform.translate(
              offset: Offset(dx, dy),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.85),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AngleRow extends StatelessWidget {
  final String label;
  final double value;

  const _AngleRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(
          '${value.toStringAsFixed(1)}°',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
