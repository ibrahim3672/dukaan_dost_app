class PaymentModel {
  const PaymentModel({
    required this.id,
    this.customerId,
    this.udhaarId,
    this.amount = 0,
    this.note,
    this.date,
    this.createdAt,
  });

  final int id;
  final int? customerId;
  final int? udhaarId;
  final double amount;
  final String? note;
  final DateTime? date;
  final DateTime? createdAt;

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: _asInt(json['id']),
      customerId: _nullableInt(json['customer_id']),
      udhaarId: _nullableInt(json['udhaar_id']),
      amount: _asDouble(json['amount']),
      note: json['note']?.toString(),
      date: _asDate(json['date']),
      createdAt: _asDate(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id > 0) 'id': id,
    if (udhaarId != null) 'udhaar_id': udhaarId,
    'amount': amount,
    if (date != null) 'date': date!.toIso8601String(),
    if (note != null) 'note': note,
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
