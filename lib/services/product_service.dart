import '../models/customer_model.dart';
import '../models/product_model.dart';
import 'database_service.dart';

class ProductService {
  ProductService(this._api);

  final DatabaseService _api;

  Future<List<ProductModel>> fetchProducts() async {
    final response = await _api.get('/products');
    return _api.unwrapList(response).map(ProductModel.fromJson).toList();
  }

  Future<ProductModel> fetchProduct(int id) async {
    final response = await _api.get('/products/$id');
    return ProductModel.fromJson(_api.unwrapMap(response));
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await _api.post('/products', product.toJson());
    return ProductModel.fromJson(_api.unwrapMap(response));
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await _api.put(
      '/products/${product.id}',
      product.toJson(),
    );
    return ProductModel.fromJson(_api.unwrapMap(response));
  }

  Future<void> deleteProduct(int id) async => _api.delete('/products/$id');

  Future<List<CustomerModel>> fetchCustomers() async {
    final response = await _api.get('/customers');
    return _api.unwrapList(response).map(CustomerModel.fromJson).toList();
  }

  Future<CustomerModel> fetchCustomer(int id) async {
    final response = await _api.get('/customers/$id');
    return CustomerModel.fromJson(_api.unwrapMap(response));
  }

  Future<CustomerModel> createCustomer(CustomerModel customer) async {
    final response = await _api.post('/customers', customer.toJson());
    return CustomerModel.fromJson(_api.unwrapMap(response));
  }

  Future<CustomerModel> updateCustomer(CustomerModel customer) async {
    final response = await _api.put(
      '/customers/${customer.id}',
      customer.toJson(),
    );
    return CustomerModel.fromJson(_api.unwrapMap(response));
  }

  Future<void> deleteCustomer(int id) async => _api.delete('/customers/$id');
}
