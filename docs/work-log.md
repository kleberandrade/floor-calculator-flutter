# Modernization work log

- Inspected the repository and original Dart 2 manifest before choosing migration; cloned the clean remote because no checkout existed. Preserved authorship, tutorial links and application identifiers.
- Inspected Flutter/Dart, Chrome, Xcode, Android/JDK and the requested quality tools without updating a shared SDK or accepting licenses.
- Wrote failing domain tests, corrected the meter/centimeter boundary, preserved the lesson's aligned-layout and optional didactic skirting rules, and added explicit waste/full-box rounding.
- Replaced duplicated mutable models/helpers with a pure validated immutable domain; no persistence migration was needed because the original app stored nothing.
- Wrote widget tests before replacing the removed Flutter APIs. Added Material 3 form sections, responsive inline results, empty/error states, keyboard progression, reset/example controls and stale-result invalidation.
- Used test failures to correct example reset, tiny-positive-dimension rounding and extreme-number overflow. Added real narrow-screen/large-text flow and field-error checks.
- Updated Android Gradle/plugin DSL and iOS scene configuration from the installed SDK template, keeping package/bundle IDs and raising iOS minimum to match Xcode. Removed empty template native-test references.
- Extended reset tests after review; observed separate failures for a retained skirting option and text fields being repopulated by form reset. Reset now precedes clearing controllers, and loading the example restores every sample option.
- Restored the SDK-compatible official Cupertino icon font required by the adaptive iOS control after the Web build reported a missing-font warning.
- Ran analysis, nine tests/coverage, Web and Android builds, and an ARM64 iOS simulator build; documented failed attempts and platform limits rather than claiming device execution.
- Opened and read the actual project tutorial; prepared the full Portuguese revision because Medium is signed out. Left other authors' references untouched.
- Replaced the generic README with verified project instructions, extracted the original MIT notice, prepared reproducible CI, and updated/verified GitHub About and the five useful existing topics.
- Verified the first published GitHub Actions run succeeded, then added the dynamic badge for that existing workflow and branch.
- Made ordered commits for application/domain, platform/CI and documentation/evidence. Final remote commit and CI outcome are reported in the completion message; remote publishing follows the user's later explicit authorization.

## Dependency and Medium follow-up — 2026-11-17

- Audited the current registry versions before changing constraints; verified the official Flutter 3.50.0 stable reference and used a separate SDK clone, preserving the shared SDK.
- Upgraded all direct and resolvable transitive packages, migrated deprecated Material imports and retained the two exact SDK dependency pins without overrides.
- Reproduced the Android Gradle-version failure, adopted current platform configuration and rebuilt successfully. The standard iOS simulator build now succeeds.
- Re-ran all nine tests, analysis and Web build; captured the actual updated app and produced a separately labeled conceptual cover.
- Rewrote the Portuguese lesson around units, assumptions, testable domain, form state and clear results; included twelve copyable code blocks, five images and five new final challenges. Preserved article identity and external credits.
- Updated README, dependency evidence, validation notes and Flutter CI pin. Authenticated editorial access was verified on this project's own Medium tab; publication outcome is recorded separately.
