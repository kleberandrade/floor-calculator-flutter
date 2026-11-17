import 'package:material_ui/material_ui.dart';
import '../domain/estimate.dart';

String decimal(double value) => value.toStringAsFixed(2).replaceAll('.', ',');

class EstimateCard extends StatelessWidget {
  const EstimateCard({super.key, required this.result});
  final Estimate? result;
  @override
  Widget build(BuildContext context) {
    final value = result;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.grid_view_rounded,
              size: 36,
              color: Color(0xFF9A452B),
            ),
            const SizedBox(height: 20),
            Text(
              value == null ? 'Pronto para planejar?' : 'Sua lista de compra',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            if (value == null)
              const Text(
                'Preencha as medidas ou use o exemplo. A estimativa aparecerá aqui, com todos os arredondamentos.',
              )
            else ...[
              Semantics(
                liveRegion: true,
                child: Text(
                  '${value.purchasePieces} peças',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${value.boxes} caixas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _line('Área do ambiente', '${decimal(value.roomArea)} m²'),
              _line('Peças para o piso', '${value.floorPieces}'),
              _line('Fileiras × colunas', '${value.rows} × ${value.columns}'),
              _line('Peças para rodapé', '${value.skirtingPieces}'),
              _line('Com margem de perda', '${value.requiredPieces} peças'),
              const Divider(height: 28),
              _line('Área de compra', '${decimal(value.purchaseArea)} m²'),
            ],
            const SizedBox(height: 24),
            const Text(
              'COMO ESTIMAMOS',
              style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.2),
            ),
            const SizedBox(height: 8),
            const Text(
              'Paginação reta, sem reaproveitar recortes. Arredondamos cada dimensão para cima, depois a perda e as caixas completas. Não considera juntas, portas ou paginação diagonal.',
            ),
            const SizedBox(height: 12),
            const Text(
              'Confira as medidas e a paginação com o instalador antes de comprar.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    ),
  );
}
