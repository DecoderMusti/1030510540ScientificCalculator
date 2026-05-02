import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';
import 'theme/app_theme.dart';

/// Bilimsel Hesap Makinesi Uygulaması
///
/// Mimari: OOP & Separation of Concerns
/// ┌──────────────────────────────────────┐
/// │              main.dart               │ → Uygulama giriş noktası
/// ├──────────────────────────────────────┤
/// │         screens/                     │
/// │   calculator_screen.dart             │ → Ana ekran (Mediator)
/// ├──────────────────────────────────────┤
/// │         widgets/                     │
/// │   calculator_display.dart            │ → Ekran widget'ı
/// │   calculator_keypad.dart             │ → Tuş takımı widget'ı
/// │   custom_button.dart                 │ → Tekil buton widget'ı
/// ├──────────────────────────────────────┤
/// │         models/                      │
/// │   calculator_button_model.dart       │ → Buton veri modeli
/// ├──────────────────────────────────────┤
/// │         engine/                      │
/// │   calculator_engine.dart             │ → Hesaplama motoru
/// ├──────────────────────────────────────┤
/// │         theme/                       │
/// │   app_theme.dart                     │ → Tema sabitleri
/// └──────────────────────────────────────┘
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ScientificCalculatorApp());
}

/// Uygulama kök widget'ı
class ScientificCalculatorApp extends StatelessWidget {
  const ScientificCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bilimsel Hesap Makinesi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const CalculatorScreen(),
    );
  }
}
