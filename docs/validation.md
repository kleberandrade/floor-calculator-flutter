# Validation record — 2026-11-17

## Environment

- Flutter 3.41.9 stable (`00b0c91f06`), Dart 3.11.5. The global SDK was inspected, not upgraded.
- macOS 27.2.1 ARM64; Chrome 157.0.8103.79; Xcode 27.2; Android SDK 36.1.0 / Android Studio JDK 21.
- `flutter doctor -v` reports some unaccepted Android licenses. No license acceptance command was run. The installed components were sufficient for the debug APK.

## Completed checks

- `flutter test --coverage`: **9 tests passed**, covering calculation, invalid/extreme values, centimeters, waste/box rounding, decimal commas, stale results, reset, error messages and a narrow layout with 1.5× text.
- `flutter analyze`: **no issues**.
- `flutter build apk --debug`: succeeded; artifact at `build/app/outputs/flutter-apk/app-debug.apk`. Build only; no emulator/physical Android execution.
- iOS simulator ARM64 build succeeded with the command below. Build only; no simulator interaction or physical iPhone validation.
- Real Chrome preview at `http://127.0.0.1:8734/`: empty state, example, calculate, result, keyboard editing, stale-result invalidation, zero-value error and 390 × 844 narrow-screen layout inspected. The final reset fix was also exercised in Chrome: enabling skirting then loading the example restores 28 pieces / 7 boxes, and clearing leaves all six fields empty. Browser screenshots in `docs/screenshots/` are captures of the actual Flutter app, not mockups.

The default iOS simulator build initially failed because the generated minimum iOS 13 is unsupported by Xcode 27.2. This repository now targets iOS 15. The next default build hit the Flutter tool's dual-architecture packaging error (it requested `arm64 x86_64` even though `lipo` listed both). Building the host simulator architecture succeeded:

```sh
flutter build ios --simulator --no-codesign --config-only
xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner \
  -configuration Debug -sdk iphonesimulator ARCHS=arm64 \
  ONLY_ACTIVE_ARCH=YES CODE_SIGNING_ALLOWED=NO build
```

The first Web build succeeded, including Flutter's optional Wasm dry run. A later optional dry run was stopped after code changed while other projects were compiling concurrently; it is not counted as a passing check. The missing Cupertino font warning from the first build was corrected by restoring the official SDK-compatible `cupertino_icons` dependency (1.0.9). The delivered target is JavaScript/CanvasKit, built using `flutter build web --no-wasm-dry-run`; no Wasm app runtime validation is claimed.

## Test-first evidence and limitations

The new domain tests first failed because the new API did not exist. Widget tests first exposed the old null-safety/removed-widget incompatibilities. After implementation they caught the example being erased by form reset; reset was moved before setting the example. A tiny-positive-room test then caught a zero-piece rounding bug; an extreme-tile test caught an unhandled infinity-to-integer conversion. An extended reset regression also reproduced a retained skirting option after loading the example and nonempty fields after clearing: the example now resets the option, and form reset happens before clearing text controllers. Each regression was observed failing before its correction.

`coverage/lcov.info` is generated locally and ignored. Measured line coverage was **211/214 instrumented lines (98.6%)**, including **37/37 domain lines**. The remaining lines include the application entry point and a few form boundary branches. Coverage is not a mutation score and does not prove exhaustive correctness. No remote-service or storage tests exist because neither the old nor new app has those boundaries.

`crapper --root . --source-root lib --no-coverage`, `dryer --root . --source-root lib --threshold 0.8` and `mutator --root . --source-root lib --scan` were actually invoked. Each reported no supported source files: the installed versions do **not** support Dart. No CRAP/duplication/mutation score is claimed.

## Metadata, publishing and editorial status

The repository About description was updated to English and verified in the browser. The five relevant existing topics were verified and preserved: `calculator`, `construction`, `dart`, `education`, `flutter`. Static Flutter/Dart badges match the actual local SDK; the MIT badge points to the original notice extracted into LICENSE. No passing/coverage badge was invented.

The original Medium article was opened and read. The session shows “Sign in”, “Sign up” and “Unknown user”, with no editorial controls. Nothing was published there. `docs/medium-update.pt-BR.md` contains a complete Portuguese revision with exact project code. No third-party article, newsletter or follower notification was changed.
