import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/models/room_model.dart';
import 'package:floor_calculator/providers/calculator_provider.dart';
import 'package:floor_calculator/validations/floor_validation.dart';
import 'package:floor_calculator/validations/room_validation.dart';
import 'package:floor_calculator/widgets/banner_ad_widget.dart';
import 'package:floor_calculator/widgets/settings_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class FloorCalculatorPage extends ConsumerStatefulWidget {
  const FloorCalculatorPage({super.key});

  @override
  ConsumerState<FloorCalculatorPage> createState() => _FloorCalculatorPageState();
}

class _FloorCalculatorPageState extends ConsumerState<FloorCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  FloorValidation? _floorValidation;
  RoomValidation? _roomValidation;
  Locale? _lastLocale;
  int _formVersion = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context);
    if (_lastLocale != locale) {
      _floorValidation = FloorValidation(l10n);
      _roomValidation = RoomValidation(l10n);
      _lastLocale = locale;
      ref.read(calculatorProvider).updateDefaultRoomName(
            (i) => l10n.defaultRoomName(i),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(calculatorProvider);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calculatorTitle),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.clearFormTooltip,
            onPressed: () => _clear(controller, l10n),
          ),
          const SettingsMenu(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _buildForm(controller, l10n),
              ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(CalculatorController controller, AppLocalizations l10n) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionHeader(l10n.floorDimensionsSection),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: _doubleField(
                key: ValueKey('floor-w-$_formVersion'),
                label: l10n.floorWidthLabel,
                initialValue: _initialNum(controller.floor.widthCm),
                onChanged: controller.setFloorWidth,
                validator: _floorValidation!.byField(
                  controller.floor,
                  'widthCm',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _doubleField(
                key: ValueKey('floor-l-$_formVersion'),
                label: l10n.floorLengthLabel,
                initialValue: _initialNum(controller.floor.lengthCm),
                onChanged: controller.setFloorLength,
                validator: _floorValidation!.byField(
                  controller.floor,
                  'lengthCm',
                ),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: _doubleField(
                key: ValueKey('floor-p-$_formVersion'),
                label: l10n.pricePerBoxLabel,
                initialValue: _initialNum(controller.floor.pricePerBox),
                onChanged: controller.setFloorPrice,
                validator: _floorValidation!.byField(
                  controller.floor,
                  'pricePerBox',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _intField(
                key: ValueKey('floor-pb-$_formVersion'),
                label: l10n.piecesPerBoxLabel,
                initialValue: controller.floor.piecesPerBox > 0
                    ? controller.floor.piecesPerBox.toString()
                    : '',
                onChanged: controller.setFloorPiecesPerBox,
                validator: _floorValidation!.byField(
                  controller.floor,
                  'piecesPerBox',
                ),
              ),
            ),
          ]),
          const SizedBox(height: 24),
          _sectionHeader(l10n.wastageLabel(
            controller.wastagePercent.toStringAsFixed(0),
          )),
          Slider(
            value: controller.wastagePercent,
            min: 0,
            max: 30,
            divisions: 30,
            label: '${controller.wastagePercent.toStringAsFixed(0)}%',
            onChanged: controller.setWastagePercent,
          ),
          const SizedBox(height: 12),
          _sectionHeader(l10n.roomsSection),
          const SizedBox(height: 12),
          ..._buildRoomCards(controller, l10n),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => _addRoom(controller),
            icon: const Icon(Icons.add),
            label: Text(l10n.addRoom),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => _calculate(controller, l10n),
            child: Text(l10n.calculateButton),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRoomCards(
    CalculatorController controller,
    AppLocalizations l10n,
  ) {
    final cards = <Widget>[];
    for (var i = 0; i < controller.rooms.length; i++) {
      cards.add(_buildRoomCard(controller, i, controller.rooms[i], l10n));
      cards.add(const SizedBox(height: 12));
    }
    return cards;
  }

  Widget _buildRoomCard(
    CalculatorController controller,
    int index,
    RoomModel room,
    AppLocalizations l10n,
  ) {
    final canDelete = controller.rooms.length > 1;
    return Card(
      key: ValueKey('room-$index-$_formVersion'),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: room.name,
                    decoration: InputDecoration(
                      labelText: l10n.roomNameLabel,
                      border: InputBorder.none,
                    ),
                    onChanged: (v) => controller.setRoomName(index, v),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l10n.removeRoom,
                  onPressed:
                      canDelete ? () => _removeRoom(controller, index) : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: _doubleField(
                  label: l10n.roomWidthLabel,
                  initialValue: _initialNum(room.width),
                  onChanged: (v) => controller.setRoomWidth(index, v),
                  validator: _roomValidation!.byField(room, 'width'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _doubleField(
                  label: l10n.roomLengthLabel,
                  initialValue: _initialNum(room.length),
                  onChanged: (v) => controller.setRoomLength(index, v),
                  validator: _roomValidation!.byField(room, 'length'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _doubleField({
    Key? key,
    required String label,
    required String initialValue,
    required void Function(String) onChanged,
    required String? Function([String?]) validator,
  }) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
      ],
      onChanged: onChanged,
      validator: (value) => validator(value),
    );
  }

  Widget _intField({
    Key? key,
    required String label,
    required String initialValue,
    required void Function(String) onChanged,
    required String? Function([String?]) validator,
  }) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      validator: (value) => validator(value),
    );
  }

  Widget _sectionHeader(String label) {
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      height: 40,
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _initialNum(num value) {
    if (value <= 0) return '';
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void _addRoom(CalculatorController controller) {
    setState(() => _formVersion++);
    controller.addRoom();
  }

  void _removeRoom(CalculatorController controller, int index) {
    setState(() => _formVersion++);
    controller.removeRoom(index);
  }

  void _clear(CalculatorController controller, AppLocalizations l10n) {
    controller.reset();
    setState(() => _formVersion++);
    _formKey.currentState?.reset();
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      title: Text(l10n.clearedToast),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.bottomCenter,
    );
  }

  void _calculate(CalculatorController controller, AppLocalizations l10n) {
    final state = _formKey.currentState;
    if (state == null || !state.validate()) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: Text(l10n.calculateErrorTitle),
        description: Text(l10n.calculateErrorDesc),
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.bottomCenter,
      );
      return;
    }
    final result = controller.calculate();
    ref.read(lastResultProvider.notifier).state = result;
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(l10n.calculateSuccessToast),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.bottomCenter,
    );
    context.push('/result');
  }
}
