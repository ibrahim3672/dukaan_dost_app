import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_theme.dart';
import '../providers/products_provider.dart';
import '../providers/sales_provider.dart';
import '../providers/udhaar_provider.dart';
import '../widgets/common_widgets.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<SalesProvider, UdhaarProvider, ProductsProvider>(
      builder: (context, salesProvider, udhaarProvider, productsProvider, _) {
        final sales = salesProvider.sales;
        final salesTotal = sales.fold<double>(
          0,
          (sum, sale) => sum + sale.totalAmount,
        );
        final udhaarTotal = udhaarProvider.udhaar.fold<double>(
          0,
          (sum, item) => sum + item.remainingBalance,
        );
        final itemsSold = sales.fold<int>(
          0,
          (sum, sale) =>
              sum +
              sale.items.fold<int>(
                0,
                (itemSum, item) => itemSum + item.quantity.toInt(),
              ),
        );

        return AppScroll(
          children: [
            const SectionHeader('Reports', action: 'API'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    'Sales',
                    'Rs. ${salesTotal.toStringAsFixed(0)}',
                    Icons.payments_rounded,
                    C.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    'Products',
                    '${productsProvider.products.length}',
                    Icons.inventory_2_rounded,
                    C.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    'Udhaar',
                    'Rs. ${udhaarTotal.toStringAsFixed(0)}',
                    Icons.history_edu_rounded,
                    C.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    'Items Sold',
                    '$itemsSold',
                    Icons.inventory_2_rounded,
                    C.tertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Sales Trend',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 18),
                  SizedBox(height: 180, child: MiniBars(large: true)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader('All Sales', action: '${sales.length} total'),
            const SizedBox(height: 12),
            if (salesProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (salesProvider.error != null)
              ApiStateMessage(message: salesProvider.error!, isError: true)
            else if (sales.isEmpty)
              const ApiStateMessage(message: 'No sales found.')
            else
              ...sales.map(
                (sale) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SaleTile(
                    customer:
                        sale.customerName ??
                        'Customer #${sale.customerId ?? '-'}',
                    product: sale.items.isEmpty
                        ? 'Sale #${sale.id}'
                        : sale.items
                              .map(
                                (item) =>
                                    item.productName ??
                                    'Product #${item.productId}',
                              )
                              .join(', '),
                    quantity: sale.items.isEmpty
                        ? '${sale.items.length} items'
                        : sale.items
                              .map(
                                (item) =>
                                    '${item.quantity.toStringAsFixed(0)} ${item.unit ?? ''}'
                                        .trim(),
                              )
                              .join(', '),
                    amount: 'Rs. ${sale.totalAmount.toStringAsFixed(0)}',
                    time:
                        (sale.date ?? sale.createdAt)
                            ?.toLocal()
                            .toString()
                            .split('.')
                            .first ??
                        '',
                    paymentType: sale.paymentType,
                    isUdhaar:
                        sale.dueAmount > 0 || sale.paymentType == 'udhaar',
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
