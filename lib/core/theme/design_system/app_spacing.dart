import 'package:flutter/material.dart';

/// Standardized spacing constants following industry standards.
/// Use these constraints for paddings, margins, and sized boxes.
class AppSpacing {
  AppSpacing._();

  /// 2.0
  static const double xxs = 2.0;

  /// 4.0
  static const double xs = 4.0;

  /// 8.0
  static const double sm = 8.0;

  /// 12.0
  static const double smL = 12.0;

  /// 16.0
  static const double md = 16.0;

  /// 24.0
  static const double lg = 24.0;

  /// 32.0
  static const double xl = 32.0;

  /// 48.0
  static const double xxl = 48.0;

  /// 64.0
  static const double xxxl = 64.0;
}

/// Standardized border radii.
class AppRadius {
  AppRadius._();

  /// 4.0
  static const double sm = 4.0;

  /// 8.0
  static const double md = 8.0;

  /// 12.0
  static const double lg = 12.0;

  /// 16.0
  static const double xl = 16.0;

  /// 24.0
  static const double xxl = 24.0;

  /// Completely round border radius
  static const double circular = 999.0;
}

/// Edge Insets presets for easy usage.
class AppInsets {
  AppInsets._();

  /// EdgeInsets.all(AppSpacing.xs) - 4.0
  static const EdgeInsets xs = EdgeInsets.all(AppSpacing.xs);

  /// EdgeInsets.all(AppSpacing.sm) - 8.0
  static const EdgeInsets sm = EdgeInsets.all(AppSpacing.sm);

  /// EdgeInsets.all(AppSpacing.md) - 16.0
  static const EdgeInsets md = EdgeInsets.all(AppSpacing.md);

  /// EdgeInsets.all(AppSpacing.lg) - 24.0
  static const EdgeInsets lg = EdgeInsets.all(AppSpacing.lg);

  /// EdgeInsets.all(AppSpacing.xl) - 32.0
  static const EdgeInsets xl = EdgeInsets.all(AppSpacing.xl);

  /// Screen horizontal padding preset (usually 16.0)
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(horizontal: AppSpacing.md);
}

/// Helper extension on double to create spacing widgets easily.
extension SpacingExtension on double {
  /// Returns a SizedBox with `height` equal to this double.
  SizedBox get verticalSpace => SizedBox(height: this);

  /// Returns a SizedBox with `width` equal to this double.
  SizedBox get horizontalSpace => SizedBox(width: this);
}
