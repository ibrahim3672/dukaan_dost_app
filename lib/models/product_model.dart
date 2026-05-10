class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.unit,
    this.category,
    this.stock = 0,
    this.purchasePrice = 0,
    this.salePrice = 0,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String unit;
  final String? category;
  final double stock;
  final double purchasePrice;
  final double salePrice;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: _asInt(json['id']),
      name: (json['name'] ?? json['product_name'] ?? '').toString(),
      unit: (json['unit'] ?? 'pcs').toString(),
      category: json['category']?.toString(),
      stock: _asDouble(
        json['stock_qty'] ??
            json['stock'] ??
            json['quantity'] ??
            json['initial_stock'],
      ),
      purchasePrice: _asDouble(json['purchase_price'] ?? json['purchasePrice']),
      salePrice: _asDouble(
        json['price'] ?? json['sale_price'] ?? json['salePrice'],
      ),
      imageUrl: (json['image_url'] ?? json['image'])?.toString(),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id > 0) 'id': id,
    'name': name,
    'unit': unit,
    if (category != null) 'category': category,
    'stock_qty': stock.round(),
    'price': salePrice,
    if (imageUrl != null) 'image_url': imageUrl,
  };
}

int _asInt(dynamic value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '') ?? 0;
double _asDouble(dynamic value) => value is num
    ? value.toDouble()
    : double.tryParse(value?.toString() ?? '') ?? 0;
DateTime? _asDate(dynamic value) =>
    value == null ? null : DateTime.tryParse(value.toString());
