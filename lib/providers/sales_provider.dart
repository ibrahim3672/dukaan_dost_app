import 'package:flutter/foundation.dart';

import '../models/sale_model.dart';
import '../services/sales_service.dart';

class SalesProvider extends ChangeNotifier {
  SalesProvider(this._service);

  final SalesService _service;
  List<SaleModel> sales = [];
  bool isLoading = false;
  String? error;

  Future<void> loadSales() async =>
      _run(() async => sales = await _service.fetchSales());

  Future<SaleModel?> createSale(SaleModel sale) async {
    SaleModel? created;
    await _run(() async {
      created = await _service.createSale(sale);
      sales = [created!, ...sales];
    });
    return created;
  }

  Future<SaleModel?> fetchSale(int id) async {
    SaleModel? sale;
    await _run(() async => sale = await _service.fetchSale(id));
    return sale;
  }

  Future<void> _run(Future<void> Function() action) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await action();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
