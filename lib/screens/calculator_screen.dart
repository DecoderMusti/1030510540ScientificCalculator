import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../engine/calculator_engine.dart';
import '../models/calculator_button_model.dart';
import '../theme/app_theme.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';

/// Hesap makinesi ana ekranı.
/// OOP - Mediator Pattern: Bu ekran, UI bileşenleri ile hesaplama motoru arasında
/// bir aracı (mediator) görevi görür. Kullanıcı etkileşimlerini alır ve
/// ilgili işlemi motora yönlendirir.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    with TickerProviderStateMixin {
  // Hesaplama motoru - iş mantığını yürütür
  final CalculatorEngine _engine = CalculatorEngine();

  // Ekranda gösterilecek değerler
  String _expression = '';
  String _result = '0';

  // Son işlem sonrası durumu
  bool _shouldResetOnNextInput = false;

  // Animasyon controller'ları
  late AnimationController _displayAnimController;
  late Animation<double> _displayAnimation;

  @override
  void initState() {
    super.initState();
    // Ekran animasyonu - sonuç gösterilirken kullanılır
    _displayAnimController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _displayAnimation = CurvedAnimation(
      parent: _displayAnimController,
      curve: Curves.easeOutCubic,
    );
    _displayAnimController.forward();
  }

  @override
  void dispose() {
    _displayAnimController.dispose();
    super.dispose();
  }

  /// Bir butona basıldığında çağrılır.
  /// Butonun türüne göre uygun aksiyonu yönlendirir.
  void _onButtonPressed(CalculatorButtonModel button) {
    setState(() {
      switch (button.actionType) {
        case ButtonActionType.number:
          _handleNumber(button.text);
          break;
        case ButtonActionType.decimal:
          _handleDecimal();
          break;
        case ButtonActionType.operator:
          _handleOperator(button.text);
          break;
        case ButtonActionType.scientific:
          _handleScientific(button.text);
          break;
        case ButtonActionType.power:
          _handlePower();
          break;
        case ButtonActionType.parenthesis:
          _handleParenthesis(button.text);
          break;
        case ButtonActionType.clear:
          _handleClear();
          break;
        case ButtonActionType.delete:
          _handleDelete();
          break;
        case ButtonActionType.equals:
          _handleEquals();
          break;
      }
    });
  }

  /// Rakam girişi
  void _handleNumber(String number) {
    if (_shouldResetOnNextInput) {
      _expression = number;
      _result = '0';
      _shouldResetOnNextInput = false;
    } else {
      _expression += number;
    }
    _updateLiveResult();
  }

  /// Ondalık nokta girişi
  void _handleDecimal() {
    if (_shouldResetOnNextInput) {
      _expression = '0.';
      _result = '0';
      _shouldResetOnNextInput = false;
      return;
    }

    // Son sayıda zaten nokta var mı kontrol et
    String lastNumber = _getLastNumber();
    if (!lastNumber.contains('.')) {
      if (_expression.isEmpty ||
          _isOperatorOrParen(_expression[_expression.length - 1])) {
        _expression += '0.';
      } else {
        _expression += '.';
      }
    }
    _updateLiveResult();
  }

  /// Operatör girişi (+, -, ×, ÷)
  void _handleOperator(String op) {
    if (_shouldResetOnNextInput) {
      _shouldResetOnNextInput = false;
      // Önceki sonucu kullanarak devam et
      if (!_result.startsWith('Hata')) {
        _expression = _result + op;
        return;
      }
    }

    if (_expression.isNotEmpty) {
      // Son karakter zaten operatör ise değiştir
      String lastChar = _expression[_expression.length - 1];
      if (_isOperator(lastChar)) {
        _expression = _expression.substring(0, _expression.length - 1) + op;
      } else {
        _expression += op;
      }
    }
  }

  /// Bilimsel fonksiyon girişi (sin, cos, tan, log, sqrt)
  void _handleScientific(String func) {
    if (_shouldResetOnNextInput) {
      _expression = func;
      _result = '0';
      _shouldResetOnNextInput = false;
    } else {
      _expression += func;
    }
  }

  /// Üs alma (^)
  void _handlePower() {
    if (_expression.isNotEmpty && _shouldResetOnNextInput) {
      _expression = _result + '^';
      _shouldResetOnNextInput = false;
    } else if (_expression.isNotEmpty) {
      _expression += '^';
    }
  }

  /// Parantez girişi
  void _handleParenthesis(String paren) {
    if (_shouldResetOnNextInput) {
      if (paren == '(') {
        _expression = paren;
        _result = '0';
      }
      _shouldResetOnNextInput = false;
    } else {
      _expression += paren;
    }
    _updateLiveResult();
  }

  /// Temizle (C)
  void _handleClear() {
    _expression = '';
    _result = '0';
    _shouldResetOnNextInput = false;

    // Animasyon efekti
    _displayAnimController.reset();
    _displayAnimController.forward();
  }

  /// Son karakteri sil (⌫)
  void _handleDelete() {
    if (_shouldResetOnNextInput) {
      _expression = '';
      _result = '0';
      _shouldResetOnNextInput = false;
      return;
    }

    if (_expression.isNotEmpty) {
      // Fonksiyon ismini tamamen silmek için kontrol et
      // Örneğin "sin(" yazılmışsa hepsini birden sil
      final functions = ['sin(', 'cos(', 'tan(', 'log(', 'sqrt('];
      bool removedFunction = false;

      for (String func in functions) {
        if (_expression.endsWith(func)) {
          _expression =
              _expression.substring(0, _expression.length - func.length);
          removedFunction = true;
          break;
        }
      }

      if (!removedFunction) {
        _expression = _expression.substring(0, _expression.length - 1);
      }

      _updateLiveResult();
    }
  }

  /// Hesapla (=)
  void _handleEquals() {
    if (_expression.isEmpty) return;

    // Açık parantezleri otomatik kapat
    String closedExpression = _autoCloseParentheses(_expression);

    _result = _engine.evaluate(closedExpression);
    _shouldResetOnNextInput = true;

    // Sonuç animasyonu
    _displayAnimController.reset();
    _displayAnimController.forward();
  }

  /// Yazarken canlı sonuç göster
  void _updateLiveResult() {
    if (_expression.isEmpty) {
      _result = '0';
      return;
    }

    // Açık parantezleri geçici olarak kapat
    String testExpression = _autoCloseParentheses(_expression);

    // Son karakter operatör değilse hesaplamayı dene
    if (testExpression.isNotEmpty &&
        !_isOperator(testExpression[testExpression.length - 1])) {
      String tempResult = _engine.evaluate(testExpression);
      if (!tempResult.startsWith('Hata')) {
        _result = tempResult;
      }
    }
  }

  /// Açık parantezleri otomatik kapatır
  String _autoCloseParentheses(String expr) {
    int openCount = '('.allMatches(expr).length;
    int closeCount = ')'.allMatches(expr).length;
    return expr + ')' * (openCount - closeCount);
  }

  /// Son girilen sayıyı döndürür (ondalık nokta kontrolü için)
  String _getLastNumber() {
    String reversed = _expression.split('').reversed.join();
    String number = '';
    for (int i = 0; i < reversed.length; i++) {
      String char = reversed[i];
      if (RegExp(r'[0-9.]').hasMatch(char)) {
        number = char + number;
      } else {
        break;
      }
    }
    return number;
  }

  /// Karakter operatör mü?
  bool _isOperator(String char) {
    return ['+', '-', '×', '÷', '^'].contains(char);
  }

  /// Karakter operatör veya parantez mi?
  bool _isOperatorOrParen(String char) {
    return _isOperator(char) || char == '(';
  }

  @override
  Widget build(BuildContext context) {
    // Sistem çubuğu stilini ayarla (beyaz ikonlar, koyu arka plan)
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              // ═══════ EKRAN ALANI ═══════
              Expanded(
                flex: 3,
                child: FadeTransition(
                  opacity: _displayAnimation,
                  child: CalculatorDisplay(
                    expression: _expression,
                    result: _result,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // ═══════ TUŞ TAKIMI ═══════
              Expanded(
                flex: 7,
                child: CalculatorKeypad(
                  onButtonPressed: _onButtonPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
