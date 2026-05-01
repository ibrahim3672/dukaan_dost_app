import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScroll(
      children: [
        SectionHeader('Reports', action: 'This Month'),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                'Sales',
                'Rs. 425k',
                Icons.payments_rounded,
                C.secondary,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                'Profit',
                'Rs. 86k',
                Icons.trending_up_rounded,
                C.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                'Udhaar',
                'Rs. 18k',
                Icons.history_edu_rounded,
                C.error,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                'Items',
                '1,284',
                Icons.inventory_2_rounded,
                C.tertiary,
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        AppCard(
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
        SizedBox(height: 24),
        SectionHeader('All Sales', action: 'View Today'),
        SizedBox(height: 12),
        SaleTile(
          customer: 'Ahmed Khan',
          product: 'Chakki Atta',
          quantity: '2 kg',
          amount: 'Rs. 200',
          time: 'Today, 10:42 AM',
          paymentType: 'Cash',
        ),
        SizedBox(height: 10),
        SaleTile(
          customer: 'Mohammad Abbas',
          product: 'Cooking Oil',
          quantity: '1 x 5L',
          amount: 'Rs. 1,850',
          time: 'Today, 9:18 AM',
          paymentType: 'Udhaar',
          isUdhaar: true,
        ),
        SizedBox(height: 10),
        SaleTile(
          customer: 'Walk-in Customer',
          product: 'Basmati Rice',
          quantity: '5 kg',
          amount: 'Rs. 1,250',
          time: 'Yesterday, 8:30 PM',
          paymentType: 'Cash',
        ),
        SizedBox(height: 10),
        SaleTile(
          customer: 'Salim Khan',
          product: 'Milk Pack',
          quantity: '6 pcs',
          amount: 'Rs. 720',
          time: 'Yesterday, 6:05 PM',
          paymentType: 'Udhaar',
          isUdhaar: true,
        ),
        SizedBox(height: 10),
        SaleTile(
          customer: 'Ayesha Store',
          product: 'Sugar',
          quantity: '10 kg',
          amount: 'Rs. 1,600',
          time: 'Apr 28, 2026',
          paymentType: 'Cash',
        ),
      ],
    );
  }
}
