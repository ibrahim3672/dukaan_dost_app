import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class StockManagerScreen extends StatelessWidget {
  const StockManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        const SectionHeader('Stock Manager', action: 'Filter'),
        const SizedBox(height: 12),
        const StockTile(
          name: 'Chakki Atta 10kg',
          units: '3 units left',
          danger: true,
        ),
        const SizedBox(height: 10),
        const StockTile(name: 'Basmati Rice 5kg', units: '24 units available'),
        const SizedBox(height: 10),
        const StockTile(
          name: 'Cooking Oil 5L',
          units: '2 units left',
          danger: true,
        ),
        const SizedBox(height: 10),
        const StockTile(name: 'Milk Pack', units: '44 packs available'),
      ],
    );
  }
}
