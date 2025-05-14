import 'package:flutter/material.dart';
import '../model/product.dart';

class ScanViewModel extends ChangeNotifier {
  Product? _scannedProduct;
  bool _isLoading = false;

  Product? get scannedProduct => _scannedProduct;
  bool get isLoading => _isLoading;

  void scanBarcode(String barcode) async {
    _isLoading = true;
    notifyListeners();

    // סימולציה של טעינת נתונים לפי ברקוד
    await Future.delayed(const Duration(seconds: 2));
    _scannedProduct = Product(
      name: 'בננה',
      barcode: barcode,
      calories: 89,
    );

    _isLoading = false;
    notifyListeners();
  }

  void clearScan() {
    _scannedProduct = null;
    notifyListeners();
  }
}