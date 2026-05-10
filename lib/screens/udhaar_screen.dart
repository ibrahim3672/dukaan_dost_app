import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/app_theme.dart';
import '../models/customer_model.dart';
import '../providers/products_provider.dart';
import '../providers/sales_provider.dart';
import '../providers/udhaar_provider.dart';
import '../widgets/common_widgets.dart';

class UdhaarScreen extends StatelessWidget {
  const UdhaarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<UdhaarProvider, ProductsProvider, SalesProvider>(
      builder: (context, udhaarProvider, productsProvider, salesProvider, _) {
        final summaries = udhaarProvider.customerSummaries;
        final pendingTotal = summaries.fold<double>(
          0,
          (sum, item) => sum + item.remainingAmount,
        );
        final customers = productsProvider.customers;

        return AppScroll(
          children: [
            const SearchBox(hint: 'Search customer or phone number...'),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    'Pending',
                    'Rs. ${pendingTotal.toStringAsFixed(0)}',
                    Icons.history_edu_rounded,
                    C.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    'Customers',
                    '${customers.length}',
                    Icons.group_rounded,
                    C.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const SectionHeader('Recent Udhaar', action: 'Grouped'),
            const SizedBox(height: 12),
            if (udhaarProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (udhaarProvider.error != null)
              ApiStateMessage(message: udhaarProvider.error!, isError: true)
            else if (summaries.isEmpty)
              const ApiStateMessage(message: 'No pending udhaar found.')
            else
              ...summaries
                  .take(5)
                  .map(
                    (summary) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: UdhaarCustomer(
                        name: summary.customerName,
                        amount:
                            'Rs. ${summary.remainingAmount.toStringAsFixed(0)}',
                        note:
                            '${summary.records.length} record${summary.records.length == 1 ? '' : 's'} pending',
                        onReminder: () => _sendWhatsAppReminder(
                          context,
                          name: summary.customerName,
                          phone: summary.customerPhone,
                          amount: summary.remainingAmount,
                        ),
                        onPay: () => _showPaySheet(
                          context,
                          customerId: summary.customerId,
                          customerName: summary.customerName,
                          maxAmount: summary.remainingAmount,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            SectionHeader('All Customers', action: '${customers.length} total'),
            const SizedBox(height: 12),
            if (productsProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (productsProvider.error != null)
              ApiStateMessage(message: productsProvider.error!, isError: true)
            else if (customers.isEmpty)
              const ApiStateMessage(
                message: 'No customers found. Tap Add User to create one.',
              )
            else
              ...customers.map((customer) {
                final remaining = udhaarProvider.remainingForCustomer(
                  customer.id,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomerTile(
                    name: customer.name,
                    phone: customer.phone ?? 'No phone',
                    balance: 'Rs. ${remaining.toStringAsFixed(0)}',
                    status: remaining > 0
                        ? 'Remaining udhaar pending'
                        : 'No pending balance',
                    hasDebt: remaining > 0,
                    onTap: () => _showCustomerDetails(
                      context,
                      customer: customer,
                      remaining: remaining,
                      udhaarProvider: udhaarProvider,
                      salesProvider: salesProvider,
                    ),
                    onPay: remaining > 0
                        ? () => _showPaySheet(
                            context,
                            customerId: customer.id,
                            customerName: customer.name,
                            maxAmount: remaining,
                          )
                        : null,
                  ),
                );
              }),
          ],
        );
      },
    );
  }

  Future<void> _showPaySheet(
    BuildContext context, {
    required int customerId,
    required String customerName,
    required double maxAmount,
  }) async {
    final controller = TextEditingController(
      text: maxAmount.toStringAsFixed(0),
    );
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
                child: Consumer<UdhaarProvider>(
                  builder: (context, provider, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Pay Udhaar',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$customerName remaining: Rs. ${maxAmount.toStringAsFixed(0)}',
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
                          labelText: 'Payment amount',
                          prefixText: 'Rs. ',
                        ),
                      ),
                      if (provider.error != null) ...[
                        const SizedBox(height: 12),
                        ApiStateMessage(
                          message: provider.error!,
                          isError: true,
                        ),
                      ],
                      const SizedBox(height: 18),
                      PrimaryButton(
                        label: provider.isLoading
                            ? 'Saving...'
                            : 'Save Payment',
                        icon: Icons.payments_rounded,
                        onPressed: provider.isLoading
                            ? () {}
                            : () async {
                                final productsProvider = sheetContext
                                    .read<ProductsProvider>();
                                final salesProvider = sheetContext
                                    .read<SalesProvider>();
                                final amount =
                                    double.tryParse(controller.text) ?? 0;
                                if (amount <= 0) return;
                                final paid = await provider.payCustomerUdhaar(
                                  customerId: customerId,
                                  amount: amount > maxAmount
                                      ? maxAmount
                                      : amount,
                                );
                                if (paid && sheetContext.mounted) {
                                  await productsProvider.loadCustomers();
                                  await salesProvider.loadSales();
                                  if (sheetContext.mounted) {
                                    Navigator.pop(sheetContext);
                                  }
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    controller.dispose();
  }

  void _showCustomerDetails(
    BuildContext context, {
    required CustomerModel customer,
    required double remaining,
    required UdhaarProvider udhaarProvider,
    required SalesProvider salesProvider,
  }) {
    final records = udhaarProvider.recordsForCustomer(customer.id);
    final sales = salesProvider.sales
        .where((sale) => sale.customerId == customer.id)
        .toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.82,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: C.bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            customer.phone ?? 'No phone',
                            style: const TextStyle(color: C.outline),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                MetricCard(
                  'Collective Remaining Udhaar',
                  'Rs. ${remaining.toStringAsFixed(0)}',
                  Icons.history_edu_rounded,
                  C.error,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: remaining > 0
                            ? () => _showPaySheet(
                                context,
                                customerId: customer.id,
                                customerName: customer.name,
                                maxAmount: remaining,
                              )
                            : null,
                        icon: const Icon(Icons.payments_rounded),
                        label: const Text('Pay Udhaar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _sendWhatsAppReminder(
                          context,
                          name: customer.name,
                          phone: customer.phone,
                          amount: remaining,
                        ),
                        icon: const Icon(Icons.send_rounded),
                        label: const Text('WhatsApp'),
                        style: FilledButton.styleFrom(
                          backgroundColor: C.whatsapp,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const SectionHeader('Sold Records'),
                const SizedBox(height: 10),
                if (sales.isEmpty)
                  const ApiStateMessage(message: 'No sales for this customer.')
                else
                  ...sales.map(
                    (sale) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SaleTile(
                        customer: customer.name,
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
                            sale.dueAmount > 0 || sale.paymentType != 'cash',
                      ),
                    ),
                  ),
                const SizedBox(height: 22),
                const SectionHeader('Udhaar Payments'),
                const SizedBox(height: 10),
                if (records.expand((record) => record.payments).isEmpty)
                  const ApiStateMessage(message: 'No payments recorded yet.')
                else
                  ...records
                      .expand((record) => record.payments)
                      .map(
                        (payment) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: AppCard(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.payments_rounded,
                                color: C.secondary,
                              ),
                              title: Text(
                                'Rs. ${payment.amount.toStringAsFixed(0)} paid',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              subtitle: Text(
                                payment.date
                                        ?.toLocal()
                                        .toString()
                                        .split('.')
                                        .first ??
                                    '',
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendWhatsAppReminder(
    BuildContext context, {
    required String name,
    required String? phone,
    required double amount,
  }) async {
    if (phone == null || phone.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer phone number is missing.')),
      );
      return;
    }

    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final normalizedPhone = digits.startsWith('0')
        ? '92${digits.substring(1)}'
        : digits;
    final message = Uri.encodeComponent(
      'Assalam-o-Alaikum $name, aap ka remaining udhaar Rs. ${amount.toStringAsFixed(0)} hai. Bara-e-karam payment confirm kar dein. - DukanDost',
    );
    final uri = Uri.parse('https://wa.me/$normalizedPhone?text=$message');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open WhatsApp.')),
        );
      }
    }
  }
}
