import 'dart:async';

import 'package:alchemist/alchemist.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      forceUpdateGoldenFiles: false,
      platformGoldensConfig: PlatformGoldensConfig(
        // Em CI, normalmente só rodamos os goldens de CI (renderizados sem
        // fontes do host). Localmente também geramos goldens de plataforma.
        enabled: true,
      ),
      ciGoldensConfig: CiGoldensConfig(enabled: true),
    ),
    run: testMain,
  );
}
