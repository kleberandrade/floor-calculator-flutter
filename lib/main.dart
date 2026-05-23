import 'dart:io' show Platform;
import 'package:floor_calculator/core/router.dart';
import 'package:floor_calculator/core/theme_app.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await MobileAds.instance.initialize();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        locale: locale,
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: appRouter,
      ),
    );
  }
}
