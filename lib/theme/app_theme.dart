import 'package:flutter/material.dart';

/// Uygulama teması - Apple tarzı modern ve koyu bir tasarım.
/// OOP - Encapsulation: Tüm tema sabitleri tek bir yerde toplanmıştır.
class AppTheme {
  // ==================== RENKLER ====================

  /// Ana arka plan rengi (derin siyah)
  static const Color backgroundColor = Color(0xFF1C1C1E);

  /// Ekran arka plan rengi (saf siyah)
  static const Color displayBackground = Color(0xFF000000);

  /// Rakam butonları arka plan rengi (koyu gri)
  static const Color numberButtonColor = Color(0xFF2C2C2E);

  /// Bilimsel fonksiyon butonları arka plan rengi (mavimsi gri)
  static const Color scientificButtonColor = Color(0xFF3A3A4A);

  /// Operatör butonları arka plan rengi (turuncu)
  static const Color operatorButtonColor = Color(0xFFFF9500);

  /// Eşittir butonu arka plan rengi (yeşil)
  static const Color equalsButtonColor = Color(0xFF34C759);

  /// Temizle butonu arka plan rengi (kırmızı)
  static const Color clearButtonColor = Color(0xFFFF3B30);

  /// Silme butonu arka plan rengi (kırmızı)
  static const Color deleteButtonColor = Color(0xFFFF3B30);

  /// Ana metin rengi (beyaz)
  static const Color primaryTextColor = Color(0xFFFFFFFF);

  /// İkincil metin rengi (açık gri)
  static const Color secondaryTextColor = Color(0xFFE5E5EA);

  /// Operatör metin rengi (beyaz)
  static const Color operatorTextColor = Color(0xFFFFFFFF);

  // ==================== YAZI STİLLERİ ====================

  /// Ekrandaki ana sonuç yazı stili
  static const TextStyle displayTextStyle = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w300,
    color: primaryTextColor,
    fontFamily: '.SF Pro Display',
    letterSpacing: -1,
  );

  /// Ekrandaki ifade yazı stili (üst kısım)
  static const TextStyle expressionTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Color(0xFF8E8E93),
    fontFamily: '.SF Pro Display',
  );

  /// Buton yazı stili
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
    fontFamily: '.SF Pro Display',
  );

  /// Bilimsel buton yazı stili (biraz daha küçük)
  static const TextStyle scientificButtonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
    fontFamily: '.SF Pro Display',
  );

  // ==================== BOYUTLAR ====================

  /// Buton köşe yuvarlaklığı
  static const double buttonBorderRadius = 16.0;

  /// Butonlar arası boşluk
  static const double buttonSpacing = 10.0;

  /// Buton yüksekliği
  static const double buttonHeight = 60.0;

  // ==================== TEMA ====================

  /// Uygulama ThemeData
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: '.SF Pro Display',
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: operatorButtonColor,
        secondary: equalsButtonColor,
        surface: backgroundColor,
      ),
    );
  }
}
