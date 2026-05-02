import 'package:flutter/material.dart';

/// Buton eylem türlerini tanımlayan enum.
/// Her butonun ne tür bir işlem yapacağını belirtir.
enum ButtonActionType {
  number,       // 0-9 rakamları
  decimal,      // Ondalık nokta (.)
  operator,     // +, -, ×, ÷
  scientific,   // sin, cos, tan, log, sqrt
  power,        // ^ (üs alma)
  parenthesis,  // ( ve )
  clear,        // C (temizle)
  delete,       // ⌫ (son karakteri sil)
  equals,       // = (sonuç hesapla)
}

/// Hesap makinesi buton modelini temsil eden sınıf.
/// OOP - Encapsulation: Butonun tüm özellikleri tek bir modelde kapsüllenmiştir.
class CalculatorButtonModel {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final ButtonActionType actionType;
  final IconData? icon; // Opsiyonel ikon (silme butonu için)
  final int flex; // GridView'da kaplayacağı alan (varsayılan 1)

  const CalculatorButtonModel({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.actionType,
    this.icon,
    this.flex = 1,
  });
}
