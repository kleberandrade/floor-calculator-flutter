# Validation record — dependency and lesson refresh, 2026-11-17

## Current toolchain and package state

- Flutter **3.50.0**, Dart **3.14.0**, from the official stable tag `ab2912035e160d9cad6306df307576da6128ebdb`; the tag and remote stable head were checked against github.com/flutter/flutter.
- Local execution uses an isolated filesystem clone under the workspace toolchains directory. The Homebrew Flutter 3.41.9 shared by other projects was not changed. No global SDK update or Android license acceptance was run.
- All direct dependencies and all transitives were upgraded to their newest resolvable versions. `material_color_utilities` 0.13.0 and `test_api` 0.7.14 remain exact SDK pins; published newer versions cannot resolve without bypassing the SDK. See [dependency evidence](dependencies.md).
- macOS 27.2.1 ARM64, Chrome 157, Xcode 27.2 and Android Studio JDK 21; Java compilation target 17.

## Completed checks on the updated project

- `dart format --output=none --set-exit-if-changed lib test`: clean.
- `flutter analyze`: **no issues**.
- `flutter test --coverage`: **9 tests passed**. Measured project line coverage: **211/214 instrumented lines (98.6%)**. The pure domain has all 37 instrumented lines covered. Coverage is not a mutation score or proof of exhaustive correctness.
- `flutter build web --no-wasm-dry-run`: succeeded using the JavaScript/CanvasKit target. No Wasm runtime validation is claimed.
- `flutter build apk --debug`: succeeded after migrating to the Flutter 3.50 Android template requirements (Gradle 9.5.0 / AGP 9.3.1). Artifact: `build/app/outputs/flutter-apk/app-debug.apk`.
- `flutter build ios --simulator --no-codesign`: **succeeded with the standard command**; artifact: `build/ios/iphonesimulator/Runner.app`. The old Flutter 3.41 dual-architecture workaround is no longer required for this build.
- The real built Web app was reloaded in Chrome. The sample produces **28 pieces / 7 boxes / 10.08 m²**. Editing a dimension clears the previous estimate; zero shows an inline validation error. A separate **390 × 844** browser viewport was checked. New captures are in `docs/medium-assets/`.

These are build and browser-interaction results, not a claim of execution on physical Android/iOS devices or interaction inside an iOS simulator. Release signing remains project-specific and was not configured or deployed.

## Migration evidence

The first Flutter 3.50 analysis reported five deprecated legacy Material imports. They were replaced with `package:material_ui/material_ui.dart` following the official migration; the existing behavior tests then passed. No calculation or storage behavior was rewritten for the package upgrade.

The first remote run exposed three Dart-format differences after the package language version became 3.14. The exact format check was reproduced locally, formatting was applied using the final package configuration, and analysis plus all nine tests passed again. Checkout was also moved to the supported Node 24-based v6 action.

The first Android build rejected the old Gradle 8.14 configuration. The Flutter 3.50 template configuration was applied without using the dependency-validation bypass flag; the next APK build passed. Per-project Gradle heap/workers were bounded to avoid the generated template reserving 12 GB on a shared development computer.

Earlier test-first work caught the centimeter/meter boundary, example reset order, tiny-positive-room rounding, extreme tile overflow, retained skirting state and nonempty fields after clearing. The nine tests preserve these regressions. There is no persistence or external-service layer in this app, so there is no stored-data migration or artificial service test.

`crapper`, `dryer` and `mutator` were invoked during the modernization. Their installed versions do not support Dart and reported no supported source files. No score was invented.

## Documentation, media and publication

The README now names the verified SDK, direct packages, SDK-pinned exceptions, build commands and actual platform results. The workflow is pinned to Flutter 3.50.0. Its result for the final pushed commit is reported in the completion message; earlier passing runs on Flutter 3.41 are not used to certify this upgrade.

The Portuguese lesson has been rewritten with native code blocks, a new generated conceptual cover, four fresh app screenshots and exactly five new challenges at the end. The original article URL and authorship are preserved. Current editorial outcome and image provenance are in [medium-publishing.md](medium-publishing.md).
