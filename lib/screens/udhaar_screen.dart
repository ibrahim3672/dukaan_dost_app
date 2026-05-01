import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class UdhaarScreen extends StatelessWidget {
  const UdhaarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScroll(
      children: [
        SearchBox(hint: 'Search customer or phone number...'),
        SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                'Pending',
                'Rs. 18k',
                Icons.history_edu_rounded,
                C.error,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                'Customers',
                '12',
                Icons.group_rounded,
                C.secondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 22),
        SectionHeader('Recent Udhaar', action: 'View All'),
        SizedBox(height: 12),
        UdhaarCustomer(
          name: 'Mohammad Abbas',
          amount: 'Rs. 7,500',
          note: 'Last payment 3 days ago',
        ),
        SizedBox(height: 12),
        UdhaarCustomer(
          name: 'Salim Khan',
          amount: 'Rs. 4,240',
          note: 'Bought atta and oil',
        ),
        SizedBox(height: 12),
        UdhaarCustomer(
          name: 'Bilal Jameel',
          amount: 'Rs. 2,900',
          note: 'Reminder due today',
        ),
        SizedBox(height: 24),
        SectionHeader('All Customers', action: '12 total'),
        SizedBox(height: 12),
        CustomerTile(
          name: 'Mohammad Abbas',
          phone: '+92 300 1112233',
          balance: 'Rs. 7,500',
          status: 'Udhaar pending',
          hasDebt: true,
        ),
        SizedBox(height: 10),
        CustomerTile(
          name: 'Salim Khan',
          phone: '+92 321 8821100',
          balance: 'Rs. 4,240',
          status: 'Udhaar pending',
          hasDebt: true,
        ),
        SizedBox(height: 10),
        CustomerTile(
          name: 'Bilal Jameel',
          phone: '+92 333 7012458',
          balance: 'Rs. 2,900',
          status: 'Reminder due today',
          hasDebt: true,
        ),
        SizedBox(height: 10),
        CustomerTile(
          name: 'Ayesha Store',
          phone: '+92 345 5598711',
          balance: 'Rs. 0',
          status: 'No pending balance',
        ),
        SizedBox(height: 10),
        CustomerTile(
          name: 'Hamza Ali',
          phone: '+92 302 4549012',
          balance: 'Rs. 0',
          status: 'Regular customer',
        ),
      ],
    );
  }
}
