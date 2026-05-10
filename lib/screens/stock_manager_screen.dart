import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_theme.dart';
import '../providers/products_provider.dart';
import '../widgets/common_widgets.dart';

class StockManagerScreen extends StatelessWidget {
  const StockManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, _) {
        final products = provider.products;
        return AppScroll(
          children: [
            Row(
              children: [
                const Expanded(child: SearchBox(hint: 'Search stock...')),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () => Navigator.pushNamed(context, '/add-product'),
                  style: FilledButton.styleFrom(
                    backgroundColor: C.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(56, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Icon(Icons.add_rounded),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SectionHeader('Stock Manager', action: '${products.length} items'),
            const SizedBox(height: 12),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.error != null)
              ApiStateMessage(message: provider.error!, isError: true)
            else if (products.isEmpty)
              const ApiStateMessage(
                message: 'No products found. Add your first product.',
              )
            else
              ...products.map(
                (product) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: StockTile(
                    name: product.name,
                    units:
                        '${product.stock.toStringAsFixed(product.stock % 1 == 0 ? 0 : 2)} ${product.unit} available • Rs. ${product.salePrice.toStringAsFixed(0)}',
                    danger: product.stock <= 3,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
