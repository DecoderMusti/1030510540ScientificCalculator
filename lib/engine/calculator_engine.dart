import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

/// Hesaplama motoru - tüm matematiksel işlemler burada yapılır.
/// OOP - Separation of Concerns: UI ile iş mantığı tamamen ayrılmıştır.
/// OOP - Single Responsibility Principle: Bu sınıfın tek sorumluluğu hesaplama yapmaktır.
class CalculatorEngine {
  /// Verilen matematiksel ifadeyi parse edip sonucu döndürür.
  /// Hata durumunda "Hata" string'i döner.
  String evaluate(String expression) {
    try {
      if (expression.isEmpty) return '0';

      // İfadeyi math_expressions'ın anlayacağı formata çevir
      String prepared = _prepareExpression(expression);

      // math_expressions ile parse et ve hesapla
      Parser parser = Parser();
      Expression exp = parser.parse(prepared);
      ContextModel contextModel = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, contextModel);

      // Sonsuzluk veya NaN kontrolü
      if (result.isInfinite) return 'Hata: Sonsuz';
      if (result.isNaN) return 'Hata: Tanımsız';

      // Tam sayı kontrolü: 5.0 yerine 5 göster
      if (result == result.roundToDouble() && !result.isInfinite) {
        return result.toInt().toString();
      }

      // Ondalık kısmı 10 hanede sınırla
      String resultStr = result.toStringAsFixed(10);
      // Sondaki gereksiz sıfırları temizle
      resultStr = resultStr.replaceAll(RegExp(r'0+$'), '');
      resultStr = resultStr.replaceAll(RegExp(r'\.$'), '');

      return resultStr;
    } catch (e) {
      return 'Hata';
    }
  }

  /// Kullanıcı ifadesini math_expressions formatına dönüştürür.
  /// Örneğin: sin(30) → sin(30 * π / 180) (derece → radyan çevirimi)
  String _prepareExpression(String expression) {
    String prepared = expression;

    // Çarpma ve bölme sembollerini standart operatörlere çevir
    prepared = prepared.replaceAll('×', '*');
    prepared = prepared.replaceAll('÷', '/');

    // Trigonometrik fonksiyonları derece modunda çalıştır
    // sin(x) → sin(x * π / 180)
    prepared = _convertTrigToDegrees(prepared, 'sin');
    prepared = _convertTrigToDegrees(prepared, 'cos');
    prepared = _convertTrigToDegrees(prepared, 'tan');

    // sqrt(x) → sqrt(x)  (math_expressions doğrudan destekliyor)
    // log(x) → ln(x) / ln(10)  (math_expressions ln kullanıyor, biz log10 istiyoruz)
    prepared = _convertLog10(prepared);

    // ^ operatörünü math_expressions formatına çevir
    prepared = prepared.replaceAll('^', '^');

    return prepared;
  }

  /// Trigonometrik fonksiyonları derece cinsinden çalışacak şekilde dönüştürür.
  /// Örnek: sin(30) → sin(30 * 3.14159265358979 / 180)
  String _convertTrigToDegrees(String expression, String funcName) {
    String result = expression;
    // Fonksiyon parantezlerini bul ve dereceye çevir
    RegExp regex = RegExp('$funcName\\(');
    while (regex.hasMatch(result)) {
      int startIndex = result.indexOf(regex);
      int funcEnd = startIndex + funcName.length + 1; // '(' sonrası

      // Eşleşen kapanan parantezi bul
      int depth = 1;
      int endIndex = funcEnd;
      while (depth > 0 && endIndex < result.length) {
        if (result[endIndex] == '(') depth++;
        if (result[endIndex] == ')') depth--;
        endIndex++;
      }

      // İçerideki ifadeyi al
      String innerExpression = result.substring(funcEnd, endIndex - 1);

      // Derece → radyan çevrimli yeni ifade
      String converted =
          '$funcName(($innerExpression) * ${math.pi} / 180)';

      result = result.substring(0, startIndex) +
          converted +
          result.substring(endIndex);

      // Sonsuz döngü koruması
      break;
    }
    return result;
  }

  /// log(x) → ln(x) / ln(10) dönüşümü (log10 hesaplaması)
  String _convertLog10(String expression) {
    String result = expression;
    RegExp regex = RegExp('log\\(');
    while (regex.hasMatch(result)) {
      int startIndex = result.indexOf(regex);
      int funcEnd = startIndex + 4; // 'log(' sonrası

      // Eşleşen kapanan parantezi bul
      int depth = 1;
      int endIndex = funcEnd;
      while (depth > 0 && endIndex < result.length) {
        if (result[endIndex] == '(') depth++;
        if (result[endIndex] == ')') depth--;
        endIndex++;
      }

      // İçerideki ifadeyi al
      String innerExpression = result.substring(funcEnd, endIndex - 1);

      // log10(x) = ln(x) / ln(10)
      String converted = '(ln($innerExpression) / ln(10))';

      result = result.substring(0, startIndex) +
          converted +
          result.substring(endIndex);

      break;
    }
    return result;
  }
}
