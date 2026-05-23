import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/widgets/banner_ad_widget.dart';
import 'package:floor_calculator/widgets/settings_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: const [SettingsMenu()],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _SectionHeader(label: l10n.calculatorsSection),
                  const SizedBox(height: 12),
                  _Grid(children: [
                    _ToolCard(
                      icon: Icons.grid_on,
                      label: l10n.floorCalculatorTile,
                      onTap: () => context.push('/calculator/floor'),
                    ),
                    _ToolCard(
                      icon: Icons.format_paint,
                      label: l10n.paintCalculatorTile,
                      onTap: () => context.push('/calculator/paint'),
                    ),
                    _ToolCard(
                      icon: Icons.layers,
                      label: l10n.mortarCalculatorTile,
                      onTap: () => context.push('/calculator/mortar'),
                    ),
                    _ToolCard(
                      icon: Icons.foundation,
                      label: l10n.concreteCalculatorTile,
                      onTap: () => context.push('/calculator/concrete'),
                    ),
                    _ToolCard(
                      icon: Icons.stairs,
                      label: l10n.stairsCalculatorTile,
                      onTap: () => context.push('/calculator/stairs'),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _SectionHeader(label: l10n.toolsSection),
                  const SizedBox(height: 12),
                  _Grid(children: [
                    _ToolCard(
                      icon: Icons.straighten,
                      label: l10n.levelToolTile,
                      onTap: () => context.push('/tools/level'),
                    ),
                    _ToolCard(
                      icon: Icons.explore,
                      label: l10n.compassToolTile,
                      onTap: () => context.push('/tools/compass'),
                    ),
                    _ToolCard(
                      icon: Icons.flashlight_on,
                      label: l10n.flashlightToolTile,
                      onTap: () => context.push('/tools/flashlight'),
                    ),
                  ]),
                ],
              ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        Icon(Icons.label, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _Grid extends StatelessWidget {
  final List<Widget> children;
  const _Grid({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth >= 600 ? 4 : 3;
        return GridView.count(
          crossAxisCount: cols,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
          children: children,
        );
      },
    );
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ToolCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: colors.primary, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
