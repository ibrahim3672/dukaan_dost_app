import '../models/sale_model.dart';
import 'database_service.dart';

class SalesService {
  SalesService(this._api);

  final DatabaseService _api;

  Future<List<SaleModel>> fetchSales() async {
    final response = await _api.get('/sales');
    return _api.unwrapList(response).map(SaleModel.fromJson).toList();
  }

  Future<SaleModel> fetchSale(int id) async {
    final response = await _api.get('/sales/$id');
    return SaleModel.fromJson(_api.unwrapMap(response));
  }

  Future<SaleModel> createSale(SaleModel sale) async {
    final response = await _api.post('/sales', sale.toJson());
    return SaleModel.fromJson(_api.unwrapMap(response));
  }
}
