import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_budget/src/feature/app/model/app_theme.dart';
import 'package:my_budget/src/feature/settings/data/locale_repository.dart';
import 'package:my_budget/src/feature/settings/data/theme_repository.dart';

part 'settings_bloc.freezed.dart';

/// States for the [SettingsBloc].
@freezed
sealed class SettingsState with _$SettingsState {
  const SettingsState._();

  /// Idle state for the [SettingsBloc].
  const factory SettingsState.idle({
    /// The current locale.
    Locale? locale,

    /// The current theme mode.
    AppTheme? appTheme,
    @Default(true) bool enableNotification,
  }) = _IdleSettingsState;

  /// Processing state for the [SettingsBloc].
  const factory SettingsState.processing({
    /// The current locale.
    Locale? locale,

    /// The current theme mode.
    AppTheme? appTheme,
    @Default(true) bool enableNotification,
  }) = _ProcessingSettingsState;

  /// Error state for the [SettingsBloc].
  const factory SettingsState.error({
    /// The error message.
    required Object cause,

    /// The current locale.
    Locale? locale,

    /// The current theme mode.
    AppTheme? appTheme,
    @Default(true) bool enableNotification,
  }) = _ErrorSettingsState;
}

/// Events for the [SettingsBloc].
@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const SettingsEvent._();

  /// Event to update the theme mode.
  const factory SettingsEvent.updateTheme({
    /// The new theme mode.
    required AppTheme appTheme,
  }) = _UpdateThemeSettingsEvent;

  /// Event to update the locale.
  const factory SettingsEvent.updateLocale({
    /// The new locale.
    required Locale locale,
  }) = _UpdateLocaleSettingsEvent;

  const factory SettingsEvent.updateNotification({
    required bool enableNotification,
  }) = _UpdateNotificationSettingsEvent;
}

/// {@template settings_bloc}
/// A [Bloc] that handles the settings.
/// {@endtemplate}
final class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  /// {@macro settings_bloc}
  SettingsBloc({
    required LocaleRepository localeRepository,
    required ThemeRepository themeRepository,
    required SettingsState initialState,
  })  : _localeRepo = localeRepository,
        _themeRepo = themeRepository,
        super(initialState) {
    on<SettingsEvent>(
      (event, emit) => event.map(
        updateTheme: (event) => _updateTheme(event, emit),
        updateLocale: (event) => _updateLocale(event, emit),
        updateNotification: (event) => _updateNotification(event, emit),
      ),
    );
  }

  final LocaleRepository _localeRepo;
  final ThemeRepository _themeRepo;

  Future<void> _updateTheme(
    _UpdateThemeSettingsEvent event,
    Emitter<SettingsState> emitter,
  ) async {
    emitter(
      SettingsState.processing(
        appTheme: state.appTheme,
        locale: state.locale,
        enableNotification: state.enableNotification,
      ),
    );

    try {
      await _themeRepo.setTheme(event.appTheme);

      emitter(
        SettingsState.idle(
          appTheme: event.appTheme,
          locale: state.locale,
          enableNotification: state.enableNotification,
        ),
      );
    } on Object catch (e) {
      emitter(
        SettingsState.error(
          appTheme: state.appTheme,
          locale: state.locale,
          enableNotification: state.enableNotification,
          cause: e,
        ),
      );
      rethrow;
    }
  }

  Future<void> _updateLocale(
    _UpdateLocaleSettingsEvent event,
    Emitter<SettingsState> emitter,
  ) async {
    emitter(
      SettingsState.processing(
        appTheme: state.appTheme,
        locale: state.locale,
        enableNotification: state.enableNotification,
      ),
    );

    try {
      await _localeRepo.setLocale(event.locale);

      emitter(
        SettingsState.idle(
          appTheme: state.appTheme,
          locale: event.locale,
          enableNotification: state.enableNotification,
        ),
      );
    } on Object catch (e) {
      emitter(
        SettingsState.error(
          appTheme: state.appTheme,
          locale: state.locale,
          enableNotification: state.enableNotification,
          cause: e,
        ),
      );
      rethrow;
    }
  }

  Future<void> _updateNotification(
    _UpdateNotificationSettingsEvent event,
    Emitter<SettingsState> emitter,
  ) async {
    emitter(
      SettingsState.idle(
        appTheme: state.appTheme,
        locale: state.locale,
        enableNotification: event.enableNotification,
      ),
    );
  }
}
