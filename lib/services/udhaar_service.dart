import '../models/payment_model.dart';
import '../models/udhaar_model.dart';
import 'database_service.dart';

class UdhaarService {
  UdhaarService(this._api);

  final DatabaseService _api;

  Future<List<UdhaarModel>> fetchUdhaar() async {
    final response = await _api.get('/udhaar');
    return _api.unwrapList(response).map(UdhaarModel.fromJson).toList();
  }

  Future<UdhaarModel> fetchUdhaarById(int id) async {
    final response = await _api.get('/udhaar/$id');
    return UdhaarModel.fromJson(_api.unwrapMap(response));
  }

  Future<PaymentModel> createPayment(PaymentModel payment) async {
    final response = await _api.post('/payments', payment.toJson());
    return PaymentModel.fromJson(_api.unwrapMap(response));
  }
}
