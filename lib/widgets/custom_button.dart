import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/calculator_button_model.dart';
import '../theme/app_theme.dart';

/// Tekil hesap makinesi butonu widget'ı.
/// OOP - Single Responsibility: Tek bir butonun görünümü ve dokunma geri bildiriminden sorumludur.
class CustomButton extends StatelessWidget {
  final CalculatorButtonModel model;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.model,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: model.flex,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.buttonSpacing / 2),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Dokunma geri bildirimi (haptic feedback)
              HapticFeedback.lightImpact();
              onPressed();
            },
            borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
            splashColor: Colors.white.withAlpha(30),
            highlightColor: Colors.white.withAlpha(15),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: AppTheme.buttonHeight,
              decoration: BoxDecoration(
                color: model.backgroundColor,
                borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                // Hafif parlak kenar efekti (glassmorphism tarzı)
                border: Border.all(
                  color: Colors.white.withAlpha(13),
                  width: 0.5,
                ),
                // Hafif gölge efekti
                boxShadow: [
                  BoxShadow(
                    color: model.backgroundColor.withAlpha(60),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: model.icon != null
                    ? Icon(
                        model.icon,
                        color: model.textColor,
                        size: 26,
                      )
                    : Text(
                        model.text,
                        style: _getTextStyle(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Buton türüne göre uygun yazı stilini döndürür
  TextStyle _getTextStyle() {
    switch (model.actionType) {
      case ButtonActionType.scientific:
      case ButtonActionType.power:
      case ButtonActionType.parenthesis:
        return AppTheme.scientificButtonTextStyle.copyWith(
          color: model.textColor,
        );
      case ButtonActionType.clear:
      case ButtonActionType.equals:
        return AppTheme.buttonTextStyle.copyWith(
          color: model.textColor,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        );
      case ButtonActionType.operator:
        return AppTheme.buttonTextStyle.copyWith(
          color: model.textColor,
          fontSize: 28,
          fontWeight: FontWeight.w500,
        );
      default:
        return AppTheme.buttonTextStyle.copyWith(
          color: model.textColor,
        );
    }
  }
}
