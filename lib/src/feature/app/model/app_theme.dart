import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/src/core/assets/colors.dart';

/// {@template app_theme}
/// An immutable class that holds properties needed
/// to build a [ThemeData] for the app.
/// {@endtemplate}
@immutable
final class AppTheme with Diagnosticable {
  /// {@macro app_theme}
  AppTheme({required this.mode, required this.seed})
      : darkTheme = ThemeData(
          brightness: Brightness.dark,
          primaryTextTheme: TextTheme(
            titleLarge: const TextStyle(color: Colors.white),
          ),
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: AppColors.accent,
              onPrimary: AppColors.accent,
              secondary: AppColors.accent,
              onSecondary: AppColors.accent,
              error: Colors.red,
              onError: Colors.red,
              background: AppColors.scfBackgroundDark,
              onBackground: AppColors.scfBackgroundDark,
              surface: AppColors.ctnBackgroundDark,
              onSurface: AppColors.ctnBackgroundDark,
              primaryContainer: AppColors.ctnBackgroundDark,
              secondaryContainer: Color(0xFF767680)),
          useMaterial3: false,
        ),
        lightTheme = ThemeData(
          brightness: Brightness.light,
          primaryTextTheme: TextTheme(
            titleLarge: TextStyle(color: Colors.black),
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.accent,
            onPrimary: AppColors.accent,
            secondary: AppColors.accent,
            onSecondary: AppColors.accent,
            error: Colors.red,
            onError: Colors.red,
            background: AppColors.scfBackgroundLight,
            onBackground: AppColors.scfBackgroundLight,
            surface: AppColors.ctnBackgroundLight,
            onSurface: AppColors.ctnBackgroundLight,
            primaryContainer: AppColors.ctnBackgroundLight,
            secondaryContainer: Colors.white,
          ),
          useMaterial3: false,
        );

  /// The type of theme to use.
  final ThemeMode mode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seed;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme;

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme;

  /// The default [AppTheme].
  static final defaultTheme = AppTheme(
    mode: ThemeMode.system,
    seed: Colors.blue,
  );

  /// The [ThemeData] for this [AppTheme].
  /// This is computed based on the [mode].
  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('seed', seed));
    properties.add(EnumProperty<ThemeMode>('type', mode));
    properties.add(DiagnosticsProperty<ThemeData>('lightTheme', lightTheme));
    properties.add(DiagnosticsProperty<ThemeData>('darkTheme', darkTheme));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme &&
          runtimeType == other.runtimeType &&
          seed == other.seed &&
          mode == other.mode;

  @override
  int get hashCode => mode.hashCode ^ seed.hashCode;
}
