import 'package:flutter/material.dart';
import 'package:my_budget/src/core/localization/localization.dart';
import 'package:my_budget/src/feature/home/widget/home_screen.dart';
import 'package:my_budget/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:my_budget/src/feature/onboading/widget/ondoarding_screen.dart';
import 'package:my_budget/src/feature/settings/widget/settings_scope.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;
    final onboarding =
        DependenciesScope.of(context).sharedPreferences.getBool('onboarding') ??
            true;
    if (onboarding) {
      DependenciesScope.of(context)
          .sharedPreferences
          .setBool('onboarding', false);
    }
    return MaterialApp(
      key: _globalKey,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      locale: locale,
      home: onboarding ? const OnboardingScreen() : const HomeScreen(),
      // TODO: You may want to override the default text scaling behavior.
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: 1.0,
        maxScaleFactor: 2.0,
        child: child!,
      ),
    );
  }
}
