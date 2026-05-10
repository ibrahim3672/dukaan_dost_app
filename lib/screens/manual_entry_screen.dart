import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_theme.dart';
import '../models/product_model.dart';
import '../models/sale_item_model.dart';
import '../models/sale_model.dart';
import '../providers/products_provider.dart';
import '../providers/sales_provider.dart';
import '../providers/udhaar_provider.dart';
import '../widgets/common_widgets.dart';

class ManualEntryScreen extends StatefulWidget {
  const ManualEntryScreen({super.key});

  @override
  State<ManualEntryScreen> createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends State<ManualEntryScreen> {
  bool sale = true;
  bool cash = true;
  int? selectedCustomerId;
  final partialPaidController = TextEditingController();
  final saleQuantities = <int, int>{};
  final purchaseQuantities = <int, int>{};

  @override
  void dispose() {
    partialPaidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Manual Entry'),
        actions: [TextButton(onPressed: () {}, child: const Text('اردو'))],
      ),
      body: Consumer2<ProductsProvider, SalesProvider>(
        builder: (context, productsProvider, salesProvider, _) {
          final products = productsProvider.products;
          return AppScroll(
            bottomPadding: 24,
            children: [
              Segment(
                left: 'Sale\nفروخت',
                right: 'Purchase\nخریداری',
                leftActive: sale,
                onChanged: (v) => setState(() {
                  sale = v;
                  if (!sale) cash = true;
                }),
              ),
              const SizedBox(height: 18),
              if (productsProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (productsProvider.error != null)
                ApiStateMessage(message: productsProvider.error!, isError: true)
              else if (products.isEmpty)
                const ApiStateMessage(
                  message: 'No products found. Add products first.',
                )
              else if (sale)
                ..._saleFields(productsProvider, salesProvider)
              else
                ..._purchaseFields(productsProvider),
              const SizedBox(height: 24),
              PrimaryButton(
                label: sale
                    ? (salesProvider.isLoading ? 'Saving Sale...' : 'Save Sale')
                    : (productsProvider.isLoading
                          ? 'Saving Purchase...'
                          : 'Save Purchase'),
                icon: Icons.save_rounded,
                onPressed: () => sale
                    ? _saveSale(context, productsProvider)
                    : _savePurchase(context, productsProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _saleFields(
    ProductsProvider productsProvider,
    SalesProvider salesProvider,
  ) {
    final products = productsProvider.products;
    final customers = productsProvider.customers;
    final total = _totalAmountFor(products, saleQuantities);
    return [
      DropdownButtonFormField<int>(
        initialValue: selectedCustomerId,
        decoration: const InputDecoration(labelText: 'Customer / گاہک'),
        items: customers
            .map(
              (customer) => DropdownMenuItem(
                value: customer.id,
                child: Text(customer.name),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => selectedCustomerId = value),
      ),
      const SizedBox(height: 14),
      ..._productSelector(
        label: 'Search / Select Sale Products',
        urdu: 'فروخت کے آئٹمز منتخب کریں',
        hint: 'Search existing stock items...',
        products: products,
        quantities: saleQuantities,
      ),
      const SizedBox(height: 14),
      _SelectedProductsCard(
        title: 'Sale Items',
        subtitle: 'Har selected product ki quantity + / - se set karein.',
        emptyText: 'Select one or more sale products above',
        products: products,
        quantities: saleQuantities,
        onDecrease: (id) => _decreaseQuantity(saleQuantities, id),
        onIncrease: (id) => _increaseQuantity(saleQuantities, id),
      ),
      const SizedBox(height: 14),
      _SaleTotalCard(totalAmount: total),
      if (salesProvider.error != null) ...[
        const SizedBox(height: 12),
        ApiStateMessage(message: salesProvider.error!, isError: true),
      ],
      const SizedBox(height: 14),
      Segment(
        left: 'Cash\nنقد',
        right: 'Udhaar\nادھار',
        leftActive: cash,
        onChanged: (v) => setState(() => cash = v),
      ),
      if (!cash) ...[
        const SizedBox(height: 14),
        LabeledField(
          label: 'Partial Cash Paid',
          urdu: 'جزوی نقد ادائیگی',
          hint: '0',
          prefix: 'Rs.',
          keyboard: TextInputType.number,
          controller: partialPaidController,
        ),
        const SizedBox(height: 10),
        AppCard(
          color: const Color(0xFFFFF7E8),
          child: Row(
            children: const [
              Icon(Icons.info_rounded, color: C.error),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Enter the cash received now. The remaining bill will be saved as udhaar.',
                  style: TextStyle(
                    color: C.muted,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ];
  }

  List<Widget> _purchaseFields(ProductsProvider productsProvider) {
    final products = productsProvider.products;
    return [
      ..._productSelector(
        label: 'Search / Select Purchase Products',
        urdu: 'خریداری کے آئٹمز منتخب کریں',
        hint: 'Search existing stock items...',
        products: products,
        quantities: purchaseQuantities,
      ),
      const SizedBox(height: 14),
      _SelectedProductsCard(
        title: 'Purchase Items',
        subtitle: 'Har selected product ki quantity + / - se set karein.',
        emptyText: 'Select one or more purchase products above',
        products: products,
        quantities: purchaseQuantities,
        onDecrease: (id) => _decreaseQuantity(purchaseQuantities, id),
        onIncrease: (id) => _increaseQuantity(purchaseQuantities, id),
      ),
      if (productsProvider.error != null) ...[
        const SizedBox(height: 12),
        ApiStateMessage(message: productsProvider.error!, isError: true),
      ],
    ];
  }

  List<Widget> _productSelector({
    required String label,
    required String urdu,
    required String hint,
    required List<ProductModel> products,
    required Map<int, int> quantities,
  }) {
    return [
      LabeledField(label: label, urdu: urdu, hint: hint),
      const SizedBox(height: 14),
      SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final item = products[index];
            final selected = (quantities[item.id] ?? 0) > 0;
            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () =>
                  setState(() => quantities[item.id] = selected ? 0 : 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 178,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selected ? C.primary : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: selected ? C.primary : C.outlineLight,
                  ),
                  boxShadow: shadow,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.inventory_2_rounded,
                      color: selected ? Colors.white : C.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: selected ? Colors.white : C.text,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.unit} • Rs. ${item.salePrice.toStringAsFixed(0)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: selected
                                  ? const Color(0xFFD9FFD5)
                                  : C.outline,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      selected
                          ? Icons.check_circle_rounded
                          : Icons.add_circle_outline_rounded,
                      color: selected ? Colors.white : C.outline,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Future<void> _saveSale(
    BuildContext context,
    ProductsProvider productsProvider,
  ) async {
    final selected = _selectedProducts(
      productsProvider.products,
      saleQuantities,
    );
    if (selected.isEmpty) return;
    final total = _totalAmountFor(productsProvider.products, saleQuantities);
    final paid = cash
        ? total
        : double.tryParse(partialPaidController.text) ?? 0;
    final sale = SaleModel(
      id: 0,
      customerId: selectedCustomerId,
      totalAmount: total,
      paidAmount: paid,
      dueAmount: total - paid,
      paymentType: cash ? 'cash' : 'udhaar',
      date: DateTime.now(),
      items: selected
          .map(
            (product) => SaleItemModel(
              id: 0,
              productId: product.id,
              productName: product.name,
              unit: product.unit,
              quantity: (saleQuantities[product.id] ?? 0).toDouble(),
              price: product.salePrice,
              total: product.salePrice * (saleQuantities[product.id] ?? 0),
            ),
          )
          .toList(),
    );
    final salesProvider = context.read<SalesProvider>();
    final udhaarProvider = context.read<UdhaarProvider>();
    final refreshedProductsProvider = context.read<ProductsProvider>();
    final created = await salesProvider.createSale(sale);
    if (created != null && context.mounted) {
      await udhaarProvider.loadUdhaar();
      await refreshedProductsProvider.loadProducts();
      await refreshedProductsProvider.loadCustomers();
      if (context.mounted) Navigator.pop(context);
    }
  }

  Future<void> _savePurchase(
    BuildContext context,
    ProductsProvider productsProvider,
  ) async {
    final selected = _selectedProducts(
      productsProvider.products,
      purchaseQuantities,
    );
    for (final product in selected) {
      final quantity = purchaseQuantities[product.id] ?? 0;
      await productsProvider.updateProduct(
        ProductModel(
          id: product.id,
          name: product.name,
          unit: product.unit,
          category: product.category,
          stock: product.stock + quantity,
          salePrice: product.salePrice,
          purchasePrice: product.purchasePrice,
          imageUrl: product.imageUrl,
        ),
      );
    }
    if (selected.isNotEmpty && context.mounted) Navigator.pop(context);
  }

  List<ProductModel> _selectedProducts(
    List<ProductModel> products,
    Map<int, int> quantities,
  ) {
    return products
        .where((product) => (quantities[product.id] ?? 0) > 0)
        .toList();
  }

  double _totalAmountFor(
    List<ProductModel> products,
    Map<int, int> quantities,
  ) {
    return products.fold(
      0,
      (sum, product) => sum + product.salePrice * (quantities[product.id] ?? 0),
    );
  }

  void _decreaseQuantity(Map<int, int> quantities, int id) {
    setState(() {
      final current = quantities[id] ?? 0;
      quantities[id] = current > 1 ? current - 1 : 0;
    });
  }

  void _increaseQuantity(Map<int, int> quantities, int id) {
    setState(() => quantities[id] = (quantities[id] ?? 0) + 1);
  }
}

class _SaleTotalCard extends StatelessWidget {
  const _SaleTotalCard({required this.totalAmount});

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: C.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.payments_rounded, color: C.primary),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    color: C.outline,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'کل رقم',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: C.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Rs. ${totalAmount.toStringAsFixed(0)}',
            style: const TextStyle(
              color: C.primary,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedProductsCard extends StatelessWidget {
  const _SelectedProductsCard({
    required this.title,
    required this.subtitle,
    required this.emptyText,
    required this.products,
    required this.quantities,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String title;
  final String subtitle;
  final String emptyText;
  final List<ProductModel> products;
  final Map<int, int> quantities;
  final ValueChanged<int> onDecrease;
  final ValueChanged<int> onIncrease;

  @override
  Widget build(BuildContext context) {
    final selected = products
        .where((product) => (quantities[product.id] ?? 0) > 0)
        .toList();
    return AppCard(
      color: const Color(0x1AACF4A4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: C.outline,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          if (selected.isEmpty)
            _EmptyProductSelection(text: emptyText)
          else
            ...selected.map(
              (product) => Padding(
                padding: EdgeInsets.only(
                  bottom: product.id == selected.last.id ? 0 : 12,
                ),
                child: _EntryProductRow(
                  product: product,
                  quantity: quantities[product.id] ?? 0,
                  onDecrease: () => onDecrease(product.id),
                  onIncrease: () => onIncrease(product.id),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EntryProductRow extends StatelessWidget {
  const _EntryProductRow({
    required this.product,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: C.outlineLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Unit: ${product.unit} • Price: Rs. ${product.salePrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: C.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          QuantityStepper(
            quantity: quantity,
            unit: product.unit,
            onDecrease: onDecrease,
            onIncrease: onIncrease,
          ),
        ],
      ),
    );
  }
}

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.unit,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final String unit;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QuantityButton(icon: Icons.remove_rounded, onTap: onDecrease),
        Container(
          width: 72,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: C.surfaceLow,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Text(
                '$quantity',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                unit,
                style: const TextStyle(
                  color: C.outline,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        _QuantityButton(icon: Icons.add_rounded, onTap: onIncrease),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: C.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _EmptyProductSelection extends StatelessWidget {
  const _EmptyProductSelection({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: C.outlineLight),
      ),
      child: Column(
        children: [
          const Icon(Icons.add_shopping_cart_rounded, color: C.outline),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color: C.outline,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
