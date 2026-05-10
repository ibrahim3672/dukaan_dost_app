import 'payment_model.dart';

class UdhaarModel {
  const UdhaarModel({
    required this.id,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.saleId,
    this.amount = 0,
    this.paidAmount = 0,
    this.remainingAmount = 0,
    this.status,
    this.payments = const [],
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int? customerId;
  final String? customerName;
  final String? customerPhone;
  final int? saleId;
  final double amount;
  final double paidAmount;
  final double remainingAmount;
  final String? status;
  final List<PaymentModel> payments;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UdhaarModel.fromJson(Map<String, dynamic> json) {
    final rawPayments = json['payments'] ?? [];
    return UdhaarModel(
      id: _asInt(json['id']),
      customerId: _nullableInt(json['customer_id']),
      customerName: (json['customer_name'] ?? json['customer']?['name'])
          ?.toString(),
      customerPhone: (json['customer_phone'] ?? json['customer']?['phone'])
          ?.toString(),
      saleId: _nullableInt(json['sale_id']),
      amount: _asDouble(json['amount'] ?? json['total_amount']),
      paidAmount: _asDouble(json['paid_amount'] ?? json['paid']),
      remainingAmount: _asDouble(
        json['remaining_amount'] ?? json['due_amount'] ?? json['remaining'],
      ),
      status: json['status']?.toString(),
      payments: rawPayments is List
          ? rawPayments
                .whereType<Map>()
                .map(
                  (item) =>
                      PaymentModel.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList()
          : const [],
      date: _asDate(json['date']),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
    );
  }

  double get remainingBalance {
    if ((status ?? '').toLowerCase() == 'paid') return 0;
    if (remainingAmount > 0) return remainingAmount;
    return (amount - paidAmount).clamp(0, double.infinity).toDouble();
  }

  bool get hasRemaining => remainingBalance > 0;

  Map<String, dynamic> toJson() => {
    if (id > 0) 'id': id,
    if (customerId != null) 'customer_id': customerId,
    if (saleId != null) 'sale_id': saleId,
    'amount': amount,
    'paid_amount': paidAmount,
    'remaining_amount': remainingAmount,
    if (status != null) 'status': status,
    if (date != null) 'date': date!.toIso8601String(),
  };
}

int _asInt(dynamic value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '') ?? 0;
int? _nullableInt(dynamic value) => value == null ? null : _asInt(value);
double _asDouble(dynamic value) => value is num
    ? value.toDouble()
    : double.tryParse(value?.toString() ?? '') ?? 0;
DateTime? _asDate(dynamic value) =>
    value == null ? null : DateTime.tryParse(value.toString());
