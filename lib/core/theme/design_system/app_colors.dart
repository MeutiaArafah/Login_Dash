import 'package:flutter/material.dart';

/// A ThemeExtension that defines semantic colors not covered by the default
/// Flutter ColorScheme, such as success, warning, info, and custom brand colors.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color success;
  final Color warning;
  final Color info;
  final Color onError;
  final Color surfaceContainer;

  const AppColorsExtension({
    required this.success,
    required this.warning,
    required this.info,
    required this.onError,
    required this.surfaceContainer,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? onError,
    Color? surfaceContainer,
  }) {
    return AppColorsExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      onError: onError ?? this.onError,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
    );
  }

  /// Default predefined light theme colors.
  static const AppColorsExtension light = AppColorsExtension(
    success: Color(0xFF2E7D32),
    warning: Color(0xFFE65100),
    info: Color(0xFF0288D1),
    onError: Colors.white,
    surfaceContainer: Color(0xFFF3F4F6),
  );

  /// Default predefined dark theme colors.
  static const AppColorsExtension dark = AppColorsExtension(
    success: Color(0xFF81C784),
    warning: Color(0xFFFFB74D),
    info: Color(0xFF4FC3F7),
    onError: Colors.black,
    surfaceContainer: Color(0xFF1F2937),
  );
}

/// Helper extension on ThemeData to easily access [AppColorsExtension].
extension AppColorsExtensionThemeContext on ThemeData {
  AppColorsExtension get appColors => extension<AppColorsExtension>() ?? AppColorsExtension.light;
}

/// Helper extension on BuildContext to easily access [AppColorsExtension].
extension BuildContextAppColorsExtension on BuildContext {
  AppColorsExtension get appColors => Theme.of(this).appColors;
}
