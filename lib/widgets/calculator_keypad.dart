import 'package:flutter/material.dart';
import '../models/calculator_button_model.dart';
import '../theme/app_theme.dart';
import 'custom_button.dart';

/// Tuş takımı widget'ı - tüm butonları grid düzeninde gösterir.
/// OOP - Single Responsibility: Sadece buton düzenlemesinden sorumludur.
class CalculatorKeypad extends StatelessWidget {
  final Function(CalculatorButtonModel) onButtonPressed;

  const CalculatorKeypad({
    super.key,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildButtonRows(),
    );
  }

  /// Tüm buton satırlarını oluşturur (7 satır)
  List<Widget> _buildButtonRows() {
    final rows = _getButtonLayout();
    return rows.map((row) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: row.map((buttonModel) {
            return CustomButton(
              model: buttonModel,
              onPressed: () => onButtonPressed(buttonModel),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  /// 7 satırlık buton düzenini tanımlar.
  /// Bu metot, görseldeki tasarıma birebir uygun buton konfigürasyonunu döndürür.
  List<List<CalculatorButtonModel>> _getButtonLayout() {
    return [
      // ═══════ 1. Satır: Bilimsel Fonksiyonlar (Mavimsi Gri) ═══════
      [
        const CalculatorButtonModel(
          text: 'sin(',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.scientific,
        ),
        const CalculatorButtonModel(
          text: 'cos(',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.scientific,
        ),
        const CalculatorButtonModel(
          text: 'tan(',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.scientific,
        ),
        const CalculatorButtonModel(
          text: 'log(',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.scientific,
        ),
      ],

      // ═══════ 2. Satır: Bilimsel Fonksiyonlar 2 (Mavimsi Gri) ═══════
      [
        const CalculatorButtonModel(
          text: 'sqrt(',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.scientific,
        ),
        const CalculatorButtonModel(
          text: '^',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.power,
        ),
        const CalculatorButtonModel(
          text: '(',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.parenthesis,
        ),
        const CalculatorButtonModel(
          text: ')',
          textColor: AppTheme.secondaryTextColor,
          backgroundColor: AppTheme.scientificButtonColor,
          actionType: ButtonActionType.parenthesis,
        ),
      ],

      // ═══════ 3. Satır: 7, 8, 9, ÷ ═══════
      [
        const CalculatorButtonModel(
          text: '7',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '8',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '9',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '÷',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.operatorButtonColor,
          actionType: ButtonActionType.operator,
        ),
      ],

      // ═══════ 4. Satır: 4, 5, 6, × ═══════
      [
        const CalculatorButtonModel(
          text: '4',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '5',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '6',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '×',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.operatorButtonColor,
          actionType: ButtonActionType.operator,
        ),
      ],

      // ═══════ 5. Satır: 1, 2, 3, - ═══════
      [
        const CalculatorButtonModel(
          text: '1',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '2',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '3',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '-',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.operatorButtonColor,
          actionType: ButtonActionType.operator,
        ),
      ],

      // ═══════ 6. Satır: 0, ., ⌫, + ═══════
      [
        const CalculatorButtonModel(
          text: '0',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.number,
        ),
        const CalculatorButtonModel(
          text: '.',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.numberButtonColor,
          actionType: ButtonActionType.decimal,
        ),
        CalculatorButtonModel(
          text: '⌫',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.deleteButtonColor,
          actionType: ButtonActionType.delete,
          icon: Icons.backspace_outlined,
        ),
        const CalculatorButtonModel(
          text: '+',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.operatorButtonColor,
          actionType: ButtonActionType.operator,
        ),
      ],

      // ═══════ 7. Satır: C (geniş) ve = (geniş) ═══════
      [
        const CalculatorButtonModel(
          text: 'C',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.clearButtonColor,
          actionType: ButtonActionType.clear,
          flex: 2,
        ),
        const CalculatorButtonModel(
          text: '=',
          textColor: AppTheme.primaryTextColor,
          backgroundColor: AppTheme.equalsButtonColor,
          actionType: ButtonActionType.equals,
          flex: 2,
        ),
      ],
    ];
  }
}
