import 'package:floor_calculator/widgets/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scaffold padrão das páginas internas de calculadora/ferramenta:
/// AppBar com botão de voltar pra home + BannerAdWidget no rodapé.
class CalcScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final FloatingActionButton? fab;

  const CalcScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        actions: actions,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: body),
            const BannerAdWidget(),
          ],
        ),
      ),
      floatingActionButton: fab,
    );
  }
}

/// Cartão de resultado mostrando uma lista de pares chave/valor.
class ResultCard extends StatelessWidget {
  final String title;
  final List<(String label, String value)> items;

  const ResultCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Divider(),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(child: Text(item.$1)),
                    Text(
                      item.$2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
