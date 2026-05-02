# Bilimsel Hesap Makinesi (Scientific Calculator)

Modern, şık (Apple tarzı) ve Nesne Yönelimli Programlama (OOP) prensiplerine uygun olarak Flutter ile geliştirilmiş tam özellikli bir bilimsel hesap makinesi.

## 📸 Ekran Görüntüsü
*(Projeni GitHub'a yükledikten sonra buraya bir ekran görüntüsü ekleyebilirsin)*

## 🚀 Özellikler

- **Temel İşlemler:** Toplama (+), Çıkarma (-), Çarpma (×), Bölme (÷)
- **Bilimsel İşlemler:** Sinüs (sin), Kosinüs (cos), Tanjant (tan), Logaritma 10 tabanı (log), Karekök (sqrt), Üs Alma (^)
- **Dinamik Ekran:** Sonuç büyüdükçe otomatik küçülen akıllı yazı boyutu
- **Hata Yönetimi:** Sıfıra bölünme, sonsuzluk ve geçersiz matematiksel ifadelerde çökme yerine "Hata" mesajı gösterme
- **Akıllı Parantez Yönetimi:** Eksik kapatılmış parantezleri otomatik hesaplama sırasında kapatma
- **Gelişmiş UX:** Dokunmatik geri bildirim (Haptic feedback), Apple iOS tarzı koyu tema (Dark Mode) ve modern UI bileşenleri

## 🏗️ Mimari ve OOP Prensipleri

Bu proje, kodun okunabilirliğini, sürdürülebilirliğini ve bakımını kolaylaştırmak için katı **OOP (Nesne Yönelimli Programlama)** prensipleriyle tasarlanmıştır.

- **Encapsulation (Kapsülleme):** Buton özellikleri `CalculatorButtonModel` içerisinde, tema ayarları ise `AppTheme` içerisinde kapsüllenmiştir.
- **Separation of Concerns (İlgi Alanlarının Ayrılması):** 
  - `models/`: Sadece veri modellerini barındırır.
  - `engine/`: İş mantığı ve matematiksel hesaplamaları yapar. Arayüzden (UI) tamamen bağımsızdır.
  - `widgets/`: Tekrar kullanılabilir ve parçalanmış UI bileşenlerini (Buton, Ekran, Tuş Takımı) içerir.
  - `screens/`: Ana uygulama ekranını tutar.
- **Single Responsibility Principle (Tek Sorumluluk Prensibi):** Her sınıfın sadece tek bir amacı vardır. Örneğin, `CalculatorEngine` sadece işlemleri çözerken, `CalculatorDisplay` sadece sonucu ekranda gösterir.
- **Mediator Pattern:** `CalculatorScreen`, kullanıcı etkileşimlerini (buton tıklamaları) alır ve hesaplama motoruna yönlendirerek aracı görevi görür.

## 📦 Kullanılan Kütüphaneler

- [math_expressions](https://pub.dev/packages/math_expressions): Metin tabanlı (String) matematiksel ifadeleri güvenli ve hızlı bir şekilde ayrıştırmak (parse) ve hesaplamak için kullanıldı.

## 🛠️ Kurulum ve Çalıştırma

Projeyi kendi bilgisayarınızda çalıştırmak için aşağıdaki adımları izleyin:

1. Projeyi klonlayın:
   ```bash
   git clone https://github.com/DecoderMusti/1030510540ScientificCalculator.git
   ```

2. Proje dizinine gidin:
   ```bash
   cd 1030510540ScientificCalculator
   ```

3. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```

4. Uygulamayı çalıştırın:
   ```bash
   flutter run
   ```

---
**Geliştirici:** [DecoderMusti](https://github.com/DecoderMusti)
