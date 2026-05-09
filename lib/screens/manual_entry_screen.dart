import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class ManualEntryScreen extends StatefulWidget {
  const ManualEntryScreen({super.key});

  @override
  State<ManualEntryScreen> createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends State<ManualEntryScreen> {
  bool sale = true;
  bool cash = true;

  final products = const [
    _EntryProduct(
      'Chakki Atta',
      'kg',
      'Rs. 100 / kg',
      100,
      Icons.grain_rounded,
    ),
    _EntryProduct(
      'Cooking Oil',
      'ltr',
      'Rs. 370 / ltr',
      370,
      Icons.water_drop_rounded,
    ),
    _EntryProduct(
      'Milk Pack',
      'pcs',
      'Rs. 120 / pcs',
      120,
      Icons.local_drink_rounded,
    ),
    _EntryProduct(
      'Basmati Rice',
      'kg',
      'Rs. 250 / kg',
      250,
      Icons.rice_bowl_rounded,
    ),
  ];

  late final List<int> saleQuantities = List<int>.filled(products.length, 0)
    ..[0] = 1;
  late final List<int> purchaseQuantities = List<int>.filled(products.length, 0)
    ..[0] = 1;

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
      body: AppScroll(
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
          if (sale) ..._saleFields() else ..._purchaseFields(),
          const SizedBox(height: 24),
          PrimaryButton(
            label: sale ? 'Save Sale' : 'Save Purchase',
            icon: Icons.save_rounded,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _saleFields() {
    return [
      const LabeledField(
        label: 'Customer',
        urdu: 'گاہک',
        hint: 'Search or add name...',
      ),
      const SizedBox(height: 14),
      ..._productSelector(
        label: 'Search / Select Sale Products',
        urdu: 'فروخت کے آئٹمز منتخب کریں',
        hint: 'Search existing stock items...',
        quantities: saleQuantities,
      ),
      const SizedBox(height: 14),
      _SelectedProductsCard(
        title: 'Sale Items',
        subtitle: 'Har selected product ki quantity + / - se set karein.',
        emptyText: 'Select one or more sale products above',
        products: products,
        quantities: saleQuantities,
        onDecrease: _decreaseSaleQuantity,
        onIncrease: _increaseSaleQuantity,
      ),
      const SizedBox(height: 14),
      _SaleTotalCard(totalAmount: _totalAmountFor(saleQuantities)),
      const SizedBox(height: 14),
      Segment(
        left: 'Cash\nنقد',
        right: 'Udhaar\nادھار',
        leftActive: cash,
        onChanged: (v) => setState(() => cash = v),
      ),
      if (!cash) ...[
        const SizedBox(height: 14),
        const LabeledField(
          label: 'Partial Cash Paid',
          urdu: 'جزوی نقد ادائیگی',
          hint: '0',
          prefix: 'Rs.',
          keyboard: TextInputType.number,
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

  List<Widget> _purchaseFields() {
    return [
      ..._productSelector(
        label: 'Search / Select Purchase Products',
        urdu: 'خریداری کے آئٹمز منتخب کریں',
        hint: 'Search existing stock items...',
        quantities: purchaseQuantities,
      ),
      const SizedBox(height: 14),
      _SelectedProductsCard(
        title: 'Purchase Items',
        subtitle: 'Har selected product ki quantity + / - se set karein.',
        emptyText: 'Select one or more purchase products above',
        products: products,
        quantities: purchaseQuantities,
        onDecrease: _decreasePurchaseQuantity,
        onIncrease: _increasePurchaseQuantity,
      ),
    ];
  }

  List<Widget> _productSelector({
    required String label,
    required String urdu,
    required String hint,
    required List<int> quantities,
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
            final selected = quantities[index] > 0;
            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => setState(() {
                quantities[index] = selected ? 0 : 1;
              }),
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
                    Icon(item.icon, color: selected ? Colors.white : C.primary),
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
                            '${item.unit} • ${item.price}',
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

  void _decreaseSaleQuantity(int index) {
    setState(() {
      if (saleQuantities[index] > 1) {
        saleQuantities[index]--;
      } else {
        saleQuantities[index] = 0;
      }
    });
  }

  void _increaseSaleQuantity(int index) {
    setState(() => saleQuantities[index]++);
  }

  void _decreasePurchaseQuantity(int index) {
    setState(() {
      if (purchaseQuantities[index] > 1) {
        purchaseQuantities[index]--;
      } else {
        purchaseQuantities[index] = 0;
      }
    });
  }

  void _increasePurchaseQuantity(int index) {
    setState(() => purchaseQuantities[index]++);
  }

  int _totalAmountFor(List<int> quantities) {
    var total = 0;
    for (var i = 0; i < products.length; i++) {
      total += products[i].priceValue * quantities[i];
    }
    return total;
  }
}

class _EntryProduct {
  const _EntryProduct(
    this.name,
    this.unit,
    this.price,
    this.priceValue,
    this.icon,
  );

  final String name;
  final String unit;
  final String price;
  final int priceValue;
  final IconData icon;
}

class _SaleTotalCard extends StatelessWidget {
  const _SaleTotalCard({required this.totalAmount});

  final int totalAmount;

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
            'Rs. $totalAmount',
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
  final List<_EntryProduct> products;
  final List<int> quantities;
  final ValueChanged<int> onDecrease;
  final ValueChanged<int> onIncrease;

  @override
  Widget build(BuildContext context) {
    final selectedIndexes = <int>[
      for (var i = 0; i < products.length; i++)
        if (quantities[i] > 0) i,
    ];

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
          if (selectedIndexes.isEmpty)
            _EmptyProductSelection(text: emptyText)
          else
            ...selectedIndexes.map((index) {
              final item = products[index];
              final quantity = quantities[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == selectedIndexes.last ? 0 : 12,
                ),
                child: _EntryProductRow(
                  product: item,
                  quantity: quantity,
                  onDecrease: () => onDecrease(index),
                  onIncrease: () => onIncrease(index),
                ),
              );
            }),
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

  final _EntryProduct product;
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
                  'Unit: ${product.unit} • Price: ${product.price}',
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
