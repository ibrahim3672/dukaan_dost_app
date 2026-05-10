import 'package:flutter/foundation.dart';

import 'auth_provider.dart';
import 'products_provider.dart';
import 'sales_provider.dart';
import 'udhaar_provider.dart';

class AppStateProvider extends ChangeNotifier {
  bool isInitialized = false;
  bool isRefreshing = false;
  String? error;

  Future<void> initialize({
    required AuthProvider auth,
    required ProductsProvider products,
    required SalesProvider sales,
    required UdhaarProvider udhaar,
  }) async {
    isRefreshing = true;
    error = null;
    notifyListeners();
    try {
      await auth.bootstrap();
      if (auth.isAuthenticated) {
        await Future.wait([
          products.loadProducts(),
          products.loadCustomers(),
          sales.loadSales(),
          udhaar.loadUdhaar(),
        ]);
      }
      isInitialized = true;
    } catch (e) {
      error = e.toString();
    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }
}
