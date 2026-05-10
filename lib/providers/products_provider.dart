import 'package:flutter/foundation.dart';

import '../models/customer_model.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsProvider(this._service);

  final ProductService _service;
  List<ProductModel> products = [];
  List<CustomerModel> customers = [];
  bool isLoading = false;
  String? error;

  Future<void> loadProducts() async =>
      _run(() async => products = await _service.fetchProducts());
  Future<void> loadCustomers() async =>
      _run(() async => customers = await _service.fetchCustomers());

  Future<ProductModel?> createProduct(ProductModel product) async {
    ProductModel? created;
    await _run(() async {
      created = await _service.createProduct(product);
      products = [created!, ...products];
    });
    return created;
  }

  Future<void> updateProduct(ProductModel product) async {
    await _run(() async {
      final updated = await _service.updateProduct(product);
      products = products
          .map((item) => item.id == updated.id ? updated : item)
          .toList();
    });
  }

  Future<void> deleteProduct(int id) async {
    await _run(() async {
      await _service.deleteProduct(id);
      products = products.where((item) => item.id != id).toList();
    });
  }

  Future<CustomerModel?> createCustomer(CustomerModel customer) async {
    CustomerModel? created;
    await _run(() async {
      created = await _service.createCustomer(customer);
      customers = [created!, ...customers];
    });
    return created;
  }

  Future<void> updateCustomer(CustomerModel customer) async {
    await _run(() async {
      final updated = await _service.updateCustomer(customer);
      customers = customers
          .map((item) => item.id == updated.id ? updated : item)
          .toList();
    });
  }

  Future<void> deleteCustomer(int id) async {
    await _run(() async {
      await _service.deleteCustomer(id);
      customers = customers.where((item) => item.id != id).toList();
    });
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
