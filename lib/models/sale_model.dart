import 'sale_item_model.dart';

class SaleModel {
  const SaleModel({
    required this.id,
    this.customerId,
    this.customerName,
    this.totalAmount = 0,
    this.paidAmount = 0,
    this.dueAmount = 0,
    this.paymentType = 'cash',
    this.items = const [],
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int? customerId;
  final String? customerName;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String paymentType;
  final List<SaleItemModel> items;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] ?? json['sale_items'] ?? [];
    final rawUdhaar = json['udhaar'];
    final udhaar = rawUdhaar is Map
        ? Map<String, dynamic>.from(rawUdhaar)
        : const <String, dynamic>{};
    final udhaarPaid = _asDouble(udhaar['paid_amount']);
    final udhaarRemaining = _asDouble(udhaar['remaining_amount']);
    final derivedPaymentType = udhaar.isEmpty
        ? 'cash'
        : (udhaarRemaining > 0 && udhaarPaid > 0 ? 'partial' : 'udhaar');
    return SaleModel(
      id: _asInt(json['id']),
      customerId: _nullableInt(json['customer_id']),
      customerName: (json['customer_name'] ?? json['customer']?['name'])
          ?.toString(),
      totalAmount: _asDouble(json['total_amount'] ?? json['total']),
      paidAmount: _asDouble(
        json['paid_amount'] ?? json['paid'] ?? udhaar['paid_amount'],
      ),
      dueAmount: _asDouble(
        json['due_amount'] ?? json['due'] ?? udhaar['remaining_amount'],
      ),
      paymentType: (json['payment_type'] ?? json['type'] ?? derivedPaymentType)
          .toString(),
      items: rawItems is List
          ? rawItems
                .whereType<Map>()
                .map(
                  (item) =>
                      SaleItemModel.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList()
          : const [],
      date: _asDate(json['date']),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id > 0) 'id': id,
    if (customerId != null) 'customer_id': customerId,
    if (customerName != null) 'customer_name': customerName,
    'total_amount': totalAmount,
    'paid_amount': paidAmount,
    'due_amount': dueAmount,
    'payment_type': paymentType,
    if (date != null) 'date': date!.toIso8601String(),
    'items': items.map((item) => item.toJson()).toList(),
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
