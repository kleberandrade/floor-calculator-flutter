import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/models/result_model.dart';
import 'package:floor_calculator/providers/calculator_provider.dart';
import 'package:floor_calculator/widgets/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final result = ref.watch(lastResultProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.resultTitle),
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
      ),
      body: Column(
        children: [
          Expanded(
            child: result == null
                ? Center(child: Text(l10n.noResultEmpty))
                : _ResultBody(result: result, l10n: l10n),
          ),
          const BannerAdWidget(),
        ],
      ),
      floatingActionButton: result == null
          ? null
          : FloatingActionButton.extended(
              icon: const Icon(Icons.share),
              label: Text(l10n.shareButton),
              onPressed: () => _share(context, result, l10n),
            ),
    );
  }

  Future<void> _share(
    BuildContext context,
    ResultModel result,
    AppLocalizations l10n,
  ) async {
    final text = _buildShareText(result, l10n);
    await Share.share(text, subject: l10n.shareBudgetTitle);
    if (context.mounted) {
      toastification.show(
        context: context,
        type: ToastificationType.info,
        style: ToastificationStyle.flatColored,
        title: Text(l10n.shareDoneToast),
        autoCloseDuration: const Duration(seconds: 2),
        alignment: Alignment.bottomCenter,
      );
    }
  }

  String _buildShareText(ResultModel result, AppLocalizations l10n) {
    final buffer = StringBuffer()
      ..writeln('*${l10n.shareBudgetTitle}*')
      ..writeln('')
      ..writeln(l10n.shareFloorLine(
        result.floor.widthCm.toStringAsFixed(0),
        result.floor.lengthCm.toStringAsFixed(0),
      ))
      ..writeln(l10n.shareWastageLine(
        result.wastagePercent.toStringAsFixed(0),
      ))
      ..writeln('');
    if (result.rooms.length > 1) {
      buffer.writeln('*${l10n.shareRoomsHeader}*');
      for (final r in result.rooms) {
        buffer.writeln(l10n.shareRoomLine(
          r.name,
          r.area.toStringAsFixed(2),
          r.totalPieces,
        ));
      }
      buffer.writeln('');
    }
    buffer
      ..writeln('*${l10n.shareSummaryHeader}*')
      ..writeln(l10n.shareFloorPieces(result.totalFloorPieces))
      ..writeln(l10n.shareFooterPieces(result.totalFooterPieces))
      ..writeln(l10n.shareTotalWithWastage(result.totalPiecesWithWastage))
      ..writeln(l10n.shareTotalArea(result.areaWithFooter.toStringAsFixed(2)));
    if (result.floor.piecesPerBox > 0) {
      buffer
        ..writeln(l10n.shareBoxes(result.totalBoxes))
        ..writeln(l10n.shareCost(result.totalCost.toStringAsFixed(2)));
    }
    return buffer.toString();
  }
}

class _ResultBody extends StatelessWidget {
  final ResultModel result;
  final AppLocalizations l10n;
  const _ResultBody({required this.result, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _section(context, l10n.quantitiesSection, [
          _tile(l10n.piecesUnit(result.totalFloorPieces),
              l10n.floorPiecesLabel),
          _tile(l10n.piecesUnit(result.totalFooterPieces),
              l10n.footerPiecesLabel),
          _tile(l10n.piecesUnit(result.totalPiecesNoWastage),
              l10n.totalPiecesNoWastageLabel),
          _tile(
            l10n.piecesUnit(result.totalPiecesWithWastage),
            l10n.totalPiecesWithWastageLabel(
              result.wastagePercent.toStringAsFixed(0),
            ),
          ),
        ]),
        const SizedBox(height: 16),
        _section(context, l10n.areasSection, [
          _tile('${result.areaWithoutFooter.toStringAsFixed(2)} m²',
              l10n.areaWithoutFooterLabel),
          _tile('${result.areaWithFooter.toStringAsFixed(2)} m²',
              l10n.areaWithFooterLabel),
        ]),
        if (result.floor.piecesPerBox > 0) ...[
          const SizedBox(height: 16),
          _section(context, l10n.costSection, [
            _tile(l10n.boxesLabel(result.totalBoxes),
                l10n.piecesPerBoxFootnote(result.floor.piecesPerBox)),
            _tile(result.totalCost.toStringAsFixed(2),
                l10n.totalCostLabel),
          ]),
        ],
        if (result.rooms.length > 1) ...[
          const SizedBox(height: 16),
          _section(
            context,
            l10n.perRoomSection,
            result.rooms
                .map(
                  (r) => _tile(
                    l10n.piecesUnit(r.totalPieces),
                    l10n.perRoomTileSubtitle(r.name, r.area.toStringAsFixed(2)),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _section(BuildContext context, String title, List<Widget> children) {
    return Card(
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _tile(String title, String subtitle) {
    return ListTile(
      dense: true,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
