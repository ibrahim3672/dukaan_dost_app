import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_theme.dart';
import '../providers/products_provider.dart';
import '../providers/sales_provider.dart';
import '../providers/udhaar_provider.dart';
import '../widgets/common_widgets.dart';
import 'dashboard_screen.dart';
import 'reports_screen.dart';
import 'stock_manager_screen.dart';
import 'udhaar_screen.dart';
import 'voice_entry_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [
    DashboardScreen(),
    UdhaarScreen(),
    VoiceEntryScreen(),
    StockManagerScreen(),
    ReportsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsProvider>()
        ..loadProducts()
        ..loadCustomers();
      context.read<SalesProvider>().loadSales();
      context.read<UdhaarProvider>().loadUdhaar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandAppBar(
        onSettings: () => Navigator.pushNamed(context, '/settings'),
      ),
      body: pages[index],
      bottomNavigationBar: DukanBottomNav(
        index: index,
        onChanged: (value) => setState(() => index = value),
      ),
      floatingActionButton: index == 1
          ? FloatingActionButton.extended(
              backgroundColor: C.primary,
              foregroundColor: Colors.white,
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const AddCustomerSheet(),
              ),
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text(
                'Add User',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            )
          : null,
    );
  }
}
