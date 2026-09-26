// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';

SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color onPrimary;
  late Color primaryContainer;
  late Color onPrimaryContainer;
  late Color onSecondary;
  late Color secondaryContainer;
  late Color onSecondaryContainer;
  late Color onAccent;
  late Color accentContainer;
  late Color onAccentContainer;
  late Color onBackground;
  late Color onSurface;
  late Color surfaceVariant;
  late Color onSurfaceVariant;
  late Color onSuccess;
  late Color onWarning;
  late Color onError;
  late Color onInfo;
  late Color transparent;
  late Color fullContrast;
  late Color primary60;
  late Color primary10;
  late Color primary20;
  late Color onPrimary70;
  late Color onPrimary60;
  late Color accent10;
  late Color onPrimary20;
  late Color secondary20;
  late Color primary5;
  late Color success10;
  late Color primary70;

  FFDesignTokens get designToken => FFDesignTokens(this);

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF000000);
  late Color secondary = const Color(0xFFE8F5E9);
  late Color tertiary = const Color(0xFFFF9800);
  late Color alternate = const Color(0xFF000000);
  late Color primaryText = const Color(0xFF000000);
  late Color secondaryText = const Color(0xFF333333);
  late Color primaryBackground = const Color(0xFFFDFCF0);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0xFF666666);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF2E7D32);
  late Color warning = const Color(0xFFF59E0B);
  late Color error = const Color(0xFFC62828);
  late Color info = const Color(0xFF2563EB);

  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color primaryContainer = const Color(0x1A000000);
  late Color onPrimaryContainer = const Color(0xFF000000);
  late Color onSecondary = const Color(0xFF000000);
  late Color secondaryContainer = const Color(0x1AE8F5E9);
  late Color onSecondaryContainer = const Color(0xFF000000);
  late Color onAccent = const Color(0xFFFFFFFF);
  late Color accentContainer = const Color(0x1AFF9800);
  late Color onAccentContainer = const Color(0xFF000000);
  late Color onBackground = const Color(0xFF000000);
  late Color onSurface = const Color(0xFF000000);
  late Color surfaceVariant = const Color(0xFFEBEBEB);
  late Color onSurfaceVariant = const Color(0xFF333333);
  late Color onSuccess = const Color(0xFFFFFFFF);
  late Color onWarning = const Color(0xFFFFFFFF);
  late Color onError = const Color(0xFFFFFFFF);
  late Color onInfo = const Color(0xFFFFFFFF);
  late Color transparent = const Color(0x00000000);
  late Color fullContrast = const Color(0xFF000000);
  late Color primary60 = const Color(0x99000000);
  late Color primary10 = const Color(0x1A000000);
  late Color primary20 = const Color(0x33000000);
  late Color onPrimary70 = const Color(0xB3FFFFFF);
  late Color onPrimary60 = const Color(0x99FFFFFF);
  late Color accent10 = const Color(0x1AFF9800);
  late Color onPrimary20 = const Color(0x33FFFFFF);
  late Color secondary20 = const Color(0x33E8F5E9);
  late Color primary5 = const Color(0x0D000000);
  late Color success10 = const Color(0x1A2E7D32);
  late Color primary70 = const Color(0xB3000000);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Noto Sans JP';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
        height: 1.12,
      );
  String get displayMediumFamily => 'Noto Sans JP';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
        height: 1.16,
      );
  String get displaySmallFamily => 'Noto Sans JP';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 36.0,
        height: 1.22,
      );
  String get headlineLargeFamily => 'Noto Sans JP';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
        height: 1.1,
      );
  String get headlineMediumFamily => 'Noto Sans JP';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 26.0,
        height: 1.1,
      );
  String get headlineSmallFamily => 'Noto Sans JP';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
        height: 1.33,
      );
  String get titleLargeFamily => 'Noto Sans JP';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        height: 1.2,
      );
  String get titleMediumFamily => 'Noto Sans JP';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        height: 1.2,
      );
  String get titleSmallFamily => 'Noto Sans JP';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.notoSansJp(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        height: 1.43,
      );
  String get labelLargeFamily => 'Noto Sans JP';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.notoSansJp(
        color: theme.secondaryText,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
        height: 1.1,
      );
  String get labelMediumFamily => 'Noto Sans JP';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.notoSansJp(
        color: theme.secondaryText,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        height: 1.1,
      );
  String get labelSmallFamily => 'Noto Sans JP';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.notoSansJp(
        color: theme.secondaryText,
        fontWeight: FontWeight.bold,
        fontSize: 10.0,
        height: 1.1,
      );
  String get bodyLargeFamily => 'Inter';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
        height: 1.4,
      );
  String get bodyMediumFamily => 'Inter';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
        height: 1.4,
      );
  String get bodySmallFamily => 'Inter';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
        height: 1.3,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFFFFFFF);
  late Color secondary = const Color(0xFF1B2E1E);
  late Color tertiary = const Color(0xFFFFB74D);
  late Color alternate = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFFFDFCF0);
  late Color secondaryText = const Color(0xFFBDBDBD);
  late Color primaryBackground = const Color(0xFF121212);
  late Color secondaryBackground = const Color(0xFF1E1E1E);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0xFF757575);
  late Color accent4 = const Color(0xB2262D34);
  late Color success = const Color(0xFF4CAF50);
  late Color warning = const Color(0xFFFBBF24);
  late Color error = const Color(0xFFEF5350);
  late Color info = const Color(0xFF60A5FA);

  late Color onPrimary = const Color(0xFF000000);
  late Color primaryContainer = const Color(0x24FFFFFF);
  late Color onPrimaryContainer = const Color(0xFFFDFCF0);
  late Color onSecondary = const Color(0xFFFFFFFF);
  late Color secondaryContainer = const Color(0x241B2E1E);
  late Color onSecondaryContainer = const Color(0xFFFDFCF0);
  late Color onAccent = const Color(0xFF000000);
  late Color accentContainer = const Color(0x24FFB74D);
  late Color onAccentContainer = const Color(0xFFFDFCF0);
  late Color onBackground = const Color(0xFFFDFCF0);
  late Color onSurface = const Color(0xFFFDFCF0);
  late Color surfaceVariant = const Color(0xFF464644);
  late Color onSurfaceVariant = const Color(0xFFBDBDBD);
  late Color onSuccess = const Color(0xFFFFFFFF);
  late Color onWarning = const Color(0xFF000000);
  late Color onError = const Color(0xFF000000);
  late Color onInfo = const Color(0xFFFFFFFF);
  late Color transparent = const Color(0x00000000);
  late Color fullContrast = const Color(0xFFFFFFFF);
  late Color primary60 = const Color(0x99FFFFFF);
  late Color primary10 = const Color(0x1AFFFFFF);
  late Color primary20 = const Color(0x33FFFFFF);
  late Color onPrimary70 = const Color(0xB3000000);
  late Color onPrimary60 = const Color(0x99000000);
  late Color accent10 = const Color(0x1AFFB74D);
  late Color onPrimary20 = const Color(0x33000000);
  late Color secondary20 = const Color(0x331B2E1E);
  late Color primary5 = const Color(0x0DFFFFFF);
  late Color success10 = const Color(0x1A4CAF50);
  late Color primary70 = const Color(0xB3FFFFFF);
}

class FFDesignTokens {
  const FFDesignTokens(this.theme);
  final FlutterFlowTheme theme;
  FFSpacing get spacing => const FFSpacing();
  FFRadius get radius => const FFRadius();
  FFShadows get shadow => FFShadows(theme);
}

class FFSpacing {
  const FFSpacing();
  double get none => 0.0;
  double get xs => 2.0;
  double get sm => 4.0;
  double get md => 8.0;
  double get lg => 12.0;
  double get xl => 16.0;
  double get xxl => 48.0;
  double get xxxl => 64.0;
}

class FFRadius {
  const FFRadius();
  double get none => 0.0;
  double get xs => 2.0;
  double get sm => 0.0;
  double get md => 2.0;
  double get lg => 4.0;
  double get xl => 24.0;
  double get xxl => 32.0;
  double get full => 9999.0;
}

class FFShadows {
  const FFShadows(this.theme);
  final FlutterFlowTheme theme;
  BoxShadow get none => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x00000000),
      offset: const Offset(0.0, 0.0),
      spreadRadius: 0.0);
  BoxShadow get xs => const BoxShadow(
      blurRadius: 1.0,
      color: const Color(0x1A000000),
      offset: const Offset(0.0, 1.0),
      spreadRadius: 0.0);
  BoxShadow get sm => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x26000000),
      offset: const Offset(1.0, 1.0),
      spreadRadius: 0.0);
  BoxShadow get md => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x33000000),
      offset: const Offset(2.0, 2.0),
      spreadRadius: 0.0);
  BoxShadow get lg => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x40000000),
      offset: const Offset(3.0, 3.0),
      spreadRadius: 0.0);
  BoxShadow get xl => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x4D000000),
      offset: const Offset(4.0, 4.0),
      spreadRadius: 0.0);
  BoxShadow get xxl => const BoxShadow(
      blurRadius: 24.0,
      color: const Color(0x1A000000),
      offset: const Offset(0.0, 12.0),
      spreadRadius: 0.0);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null && fontFamily.isNotEmpty) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}
