# Dependency audit — 2026-11-17

Verified with Flutter **3.50.0** / Dart **3.14.0**, using the official stable tag `ab2912035e160d9cad6306df307576da6128ebdb`. The isolated local SDK is a filesystem clone; the shared Homebrew SDK was not upgraded.

All direct dependencies and all SDK-resolvable transitive packages were upgraded using `flutter pub upgrade --major-versions`. There are no dependency overrides.

## Current direct dependencies

- `flutter`: from SDK 3.50.0.
- `material_ui`: **1.11.1**, latest.
- `cupertino_icons`: **2.0.0**, latest.
- `flutter_test`: from SDK 3.50.0.
- `flutter_lints`: **6.0.0**, latest.

## SDK-pinned exceptions

- `material_color_utilities`: **0.13.0**. Pub.dev latest is **0.13.1**, but `packages/flutter/pubspec.yaml` in the stable SDK pins 0.13.0.
- `test_api`: **0.7.14**. Pub.dev latest is **0.7.15**, but `packages/flutter_test/pubspec.yaml` pins 0.7.14.

Both are already at their newest resolvable version. Overriding these pins would circumvent the tested SDK dependency graph. The package request is implemented to the current stable SDK compatibility boundary; it is not a claim that every transitive package equals the registry's Latest column.

## Full resolved audit

- `async`: current **2.13.1**, resolvable **2.13.1**, latest **2.13.1** (transitive).
- `boolean_selector`: current **2.1.2**, resolvable **2.1.2**, latest **2.1.2** (transitive).
- `characters`: current **1.4.1**, resolvable **1.4.1**, latest **1.4.1** (transitive).
- `clock`: current **1.1.3**, resolvable **1.1.3**, latest **1.1.3** (transitive).
- `collection`: current **1.19.1**, resolvable **1.19.1**, latest **1.19.1** (transitive).
- `cupertino_icons`: current **2.0.0**, resolvable **2.0.0**, latest **2.0.0** (direct).
- `cupertino_ui`: current **1.1.7**, resolvable **1.1.7**, latest **1.1.7** (transitive).
- `fake_async`: current **1.3.3**, resolvable **1.3.3**, latest **1.3.3** (transitive).
- `flutter`: current **0.0.0**, resolvable **0.0.0**, latest **0.0.0** (direct).
- `flutter_lints`: current **6.0.0**, resolvable **6.0.0**, latest **6.0.0** (dev).
- `flutter_localizations`: current **0.0.0**, resolvable **0.0.0**, latest **0.0.0** (transitive).
- `flutter_test`: current **0.0.0**, resolvable **0.0.0**, latest **0.0.0** (dev).
- `intl`: current **0.20.3**, resolvable **0.20.3**, latest **0.20.3** (transitive).
- `leak_tracker`: current **11.0.2**, resolvable **11.0.2**, latest **11.0.2** (transitive).
- `leak_tracker_flutter_testing`: current **3.0.10**, resolvable **3.0.10**, latest **3.0.10** (transitive).
- `leak_tracker_testing`: current **3.0.2**, resolvable **3.0.2**, latest **3.0.2** (transitive).
- `lints`: current **6.1.0**, resolvable **6.1.0**, latest **6.1.0** (transitive).
- `listen`: current **1.0.1**, resolvable **1.0.1**, latest **1.0.1** (transitive).
- `matcher`: current **0.12.20**, resolvable **0.12.20**, latest **0.12.20** (transitive).
- `material_color_utilities`: current **0.13.0**, resolvable **0.13.0**, latest **0.13.1** (transitive).
- `material_ui`: current **1.11.1**, resolvable **1.11.1**, latest **1.11.1** (direct).
- `meta`: current **1.19.0**, resolvable **1.19.0**, latest **1.19.0** (transitive).
- `path`: current **1.9.1**, resolvable **1.9.1**, latest **1.9.1** (transitive).
- `sky_engine`: current **0.0.0**, resolvable **0.0.0**, latest **0.0.0** (transitive).
- `source_span`: current **1.10.2**, resolvable **1.10.2**, latest **1.10.2** (transitive).
- `stack_trace`: current **1.12.2**, resolvable **1.12.2**, latest **1.12.2** (transitive).
- `stream_channel`: current **2.1.4**, resolvable **2.1.4**, latest **2.1.4** (transitive).
- `string_scanner`: current **1.4.1**, resolvable **1.4.1**, latest **1.4.1** (transitive).
- `term_glyph`: current **1.2.2**, resolvable **1.2.2**, latest **1.2.2** (transitive).
- `test_api`: current **0.7.14**, resolvable **0.7.14**, latest **0.7.15** (transitive).
- `vector_math`: current **2.4.4**, resolvable **2.4.4**, latest **2.4.4** (transitive).
- `vm_service`: current **15.4.0**, resolvable **15.4.0**, latest **15.4.0** (transitive).

Machine-readable evidence is in `docs/dependencies.json`; exact checksums are in `pubspec.lock`.

## Reproduce

```sh
flutter --version
flutter pub upgrade --major-versions
flutter pub outdated --show-all
flutter analyze
flutter test --coverage
flutter build web --no-wasm-dry-run
```

Use Flutter 3.50.0 for these commands. No SDK pin was bypassed. Material imports were migrated using the [official standalone-package guide](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui). Package versions were checked against [pub.dev](https://pub.dev/).
