import 'dart:async';
import 'dart:math' as math;

import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/calc_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassToolPage extends StatefulWidget {
  const CompassToolPage({super.key});

  @override
  State<CompassToolPage> createState() => _CompassToolPageState();
}

class _CompassToolPageState extends State<CompassToolPage> {
  StreamSubscription<CompassEvent>? _sub;
  double? _heading;
  bool _unavailable = false;

  @override
  void initState() {
    super.initState();
    final stream = FlutterCompass.events;
    if (stream == null) {
      _unavailable = true;
    } else {
      _sub = stream.listen((event) {
        if (!mounted) return;
        setState(() => _heading = event.heading);
      }, onError: (_) {
        if (mounted) setState(() => _unavailable = true);
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
    return CalcScaffold(
      title: l10n.compassToolTile,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _unavailable
            ? Center(child: Text(l10n.compassUnavailable))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: _Dial(heading: _heading, l10n: l10n),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Text(l10n.compassHeading)),
                      Text(
                        _heading == null
                            ? '—'
                            : '${_heading!.toStringAsFixed(0)}°',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class _Dial extends StatelessWidget {
  final double? heading;
  final AppLocalizations l10n;

  const _Dial({required this.heading, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final angle = heading == null ? 0.0 : -heading! * math.pi / 180;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.outline, width: 2),
          ),
        ),
        Transform.rotate(
          angle: angle,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _CardinalMark(label: l10n.compassNorth, alignment: Alignment.topCenter, color: colors.primary),
              _CardinalMark(label: l10n.compassEast, alignment: Alignment.centerRight),
              _CardinalMark(label: l10n.compassSouth, alignment: Alignment.bottomCenter),
              _CardinalMark(label: l10n.compassWest, alignment: Alignment.centerLeft),
            ],
          ),
        ),
        // Agulha fixa apontando pra cima
        Icon(Icons.arrow_drop_up, size: 48, color: colors.primary),
      ],
    );
  }
}

class _CardinalMark extends StatelessWidget {
  final String label;
  final Alignment alignment;
  final Color? color;

  const _CardinalMark({
    required this.label,
    required this.alignment,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color ?? Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
