class CustomerModel {
  const CustomerModel({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    this.balance = 0,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String? phone;
  final String? address;
  final double balance;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      phone: json['phone']?.toString(),
      address: (json['address'] ?? json['note'])?.toString(),
      balance: _asDouble(
        json['balance'] ?? json['udhaar_balance'] ?? json['opening_udhaar'],
      ),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id > 0) 'id': id,
    'name': name,
    if (phone != null) 'phone': phone,
    if (address != null) 'address': address,
    'balance': balance,
  };
}

int _asInt(dynamic value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '') ?? 0;
double _asDouble(dynamic value) => value is num
    ? value.toDouble()
    : double.tryParse(value?.toString() ?? '') ?? 0;
DateTime? _asDate(dynamic value) =>
    value == null ? null : DateTime.tryParse(value.toString());
