import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Hesap makinesi ekranı widget'ı.
/// Kullanıcının girdiği ifadeyi ve sonucu gösterir.
/// OOP - Single Responsibility: Sadece ekran görüntüsünden sorumludur.
class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.displayBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Üst kısım: Girilen ifade
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              expression.isEmpty ? ' ' : expression,
              style: AppTheme.expressionTextStyle,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          // Alt kısım: Sonuç
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              result,
              style: AppTheme.displayTextStyle.copyWith(
                fontSize: _dynamicFontSize(result),
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  /// Sonuç uzunluğuna göre font boyutunu dinamik ayarla
  double _dynamicFontSize(String text) {
    if (text.length > 16) return 32;
    if (text.length > 12) return 40;
    if (text.length > 8) return 48;
    return 56;
  }
}
