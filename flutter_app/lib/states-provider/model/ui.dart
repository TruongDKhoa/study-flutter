import 'package:flutter/material.dart';

// ChangeNotifier: Nó có nhiệm vụ thông báo cho người nghe.
//
// ChangeNotifierProvider: Nó sẽ lắng nghe khi ChangeNotifier.notifyListeners
// được gọi và thông báo tới các hàm build liên quan .
//
// Consumer: đơn giản nó chỉ là một Widget do thư viện cung cấp.
// Chúng ta dùng widget này để lấy ra object thay vì phải gọi Provider.of.

class UI with ChangeNotifier {
  double _fontSize = 0.5;

  set fontSize(newValue) {
    _fontSize = newValue;
    notifyListeners(); // Notify for listener if states are changed.
  }

  double get fontSize => _fontSize * 30;
  double get sliderFontSize => _fontSize;
}
