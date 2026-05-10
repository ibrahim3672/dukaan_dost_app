import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_theme.dart';
import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../providers/sales_provider.dart';
import '../providers/udhaar_provider.dart';
import '../widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 700;
    return Consumer3<SalesProvider, UdhaarProvider, ProductsProvider>(
      builder: (context, salesProvider, udhaarProvider, productsProvider, _) {
        final salesTotal = salesProvider.sales.fold<double>(
          0,
          (sum, sale) => sum + sale.totalAmount,
        );
        final udhaarTotal = udhaarProvider.udhaar.fold<double>(
          0,
          (sum, item) => sum + item.remainingBalance,
        );
        final lowStock = productsProvider.products
            .where((product) => product.stock <= 3)
            .toList();

        return AppScroll(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: C.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: shadow,
              ),
              child: Stack(
                children: [
                  const Positioned(
                    right: -60,
                    top: -80,
                    child: Blob(size: 190, color: Colors.white10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Assalam-o-Alaikum, Shopkeeper!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Live data from Laravel API.',
                        style: TextStyle(color: Color(0xFFCBFFC2)),
                      ),
                      const SizedBox(height: 20),
                      Chip(
                        avatar: const Icon(
                          Icons.calendar_today_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Text(
                          DateTime.now().toLocal().toString().split(' ').first,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        backgroundColor: const Color(0x22FFFFFF),
                        side: BorderSide.none,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: wide ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: [
                QuickAction(
                  'Sell',
                  'بیچیں',
                  Icons.add_shopping_cart_rounded,
                  C.primary,
                  onTap: () => Navigator.pushNamed(context, '/manual'),
                ),
                QuickAction(
                  'Add Product',
                  'پروڈکٹ شامل کریں',
                  Icons.shopping_bag_rounded,
                  C.secondary,
                  onTap: () => Navigator.pushNamed(context, '/add-product'),
                ),
                QuickAction(
                  'Manual',
                  'مینول',
                  Icons.edit_document,
                  C.surfaceHighest,
                  darkText: true,
                  onTap: () => Navigator.pushNamed(context, '/manual'),
                ),
              ],
            ),
            const SizedBox(height: 22),
            MetricCard(
              "Today's Sales",
              'Rs. ${salesTotal.toStringAsFixed(0)}',
              Icons.payments_rounded,
              C.secondary,
            ),
            const SizedBox(height: 14),
            MetricCard(
              'Total Udhaar',
              'Rs. ${udhaarTotal.toStringAsFixed(0)}',
              Icons.history_edu_rounded,
              C.error,
            ),
            const SizedBox(height: 14),
            AppCard(
              border: const Border(left: BorderSide(color: C.error, width: 4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_rounded, color: C.error),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Low Stock Alert\nکم اسٹاک والے آئٹمز',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/add-product'),
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (productsProvider.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (lowStock.isEmpty)
                    const ApiStateMessage(message: 'No low stock products.')
                  else
                    ...lowStock.map(
                      (product) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: StockTile(
                          name: product.name,
                          units:
                              '${product.stock.toStringAsFixed(0)} ${product.unit} left',
                          danger: true,
                          onReorder: () => _showReorderSheet(
                            context,
                            productsProvider,
                            product,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showReorderSheet(
    BuildContext context,
    ProductsProvider provider,
    ProductModel product,
  ) async {
    final controller = TextEditingController(text: '1');
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final bottomInset = MediaQuery.viewInsetsOf(sheetContext).bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Container(
            decoration: const BoxDecoration(
              color: C.bg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Reorder ${product.name}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current stock: ${product.stock.toStringAsFixed(0)} ${product.unit}',
                      style: const TextStyle(
                        color: C.outline,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity to add',
                        prefixIcon: Icon(Icons.add_box_rounded),
                      ),
                    ),
                    const SizedBox(height: 18),
                    PrimaryButton(
                      label: 'Save Stock',
                      icon: Icons.save_rounded,
                      onPressed: () async {
                        final quantity = double.tryParse(controller.text) ?? 0;
                        if (quantity <= 0) return;
                        await provider.updateProduct(
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
                        if (sheetContext.mounted) Navigator.pop(sheetContext);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    controller.dispose();
  }
}
