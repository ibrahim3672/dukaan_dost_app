class SaleItemModel {
  const SaleItemModel({
    required this.id,
    this.saleId,
    required this.productId,
    this.productName,
    this.unit,
    this.quantity = 0,
    this.price = 0,
    this.total = 0,
  });

  final int id;
  final int? saleId;
  final int productId;
  final String? productName;
  final String? unit;
  final double quantity;
  final double price;
  final double total;

  factory SaleItemModel.fromJson(Map<String, dynamic> json) {
    return SaleItemModel(
      id: _asInt(json['id']),
      saleId: _nullableInt(json['sale_id']),
      productId: _asInt(json['product_id']),
      productName: (json['product_name'] ?? json['product']?['name'])
          ?.toString(),
      unit: (json['unit'] ?? json['product']?['unit'])?.toString(),
      quantity: _asDouble(json['quantity']),
      price: _asDouble(json['price'] ?? json['unit_price']),
      total: _asDouble(json['total'] ?? json['line_total']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id > 0) 'id': id,
    if (saleId != null) 'sale_id': saleId,
    'product_id': productId,
    if (productName != null) 'product_name': productName,
    if (unit != null) 'unit': unit,
    'quantity': quantity,
    'price': price,
    'total': total,
  };
}

int _asInt(dynamic value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '') ?? 0;
int? _nullableInt(dynamic value) => value == null ? null : _asInt(value);
double _asDouble(dynamic value) => value is num
    ? value.toDouble()
    : double.tryParse(value?.toString() ?? '') ?? 0;
