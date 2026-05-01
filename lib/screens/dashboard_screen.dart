import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 700;
    return AppScroll(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: C.primary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: shadow,
          ),
          child: const Stack(
            children: [
              Positioned(
                right: -60,
                top: -80,
                child: Blob(size: 190, color: Colors.white10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assalam-o-Alaikum, Shopkeeper!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Manage your shop efficiently with DukanDost.',
                    style: TextStyle(color: Color(0xFFCBFFC2)),
                  ),
                  SizedBox(height: 20),
                  Chip(
                    avatar: Icon(
                      Icons.calendar_today_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Apr 30, 2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    backgroundColor: Color(0x22FFFFFF),
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
              'Buy',
              'خریدیں',
              Icons.shopping_bag_rounded,
              C.secondary,
              onTap: () => Navigator.pushNamed(context, '/add-product'),
            ),
            const QuickAction(
              'Udhaar',
              'ادھار',
              Icons.account_balance_wallet_rounded,
              C.tertiaryContainer,
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
        const SalesCard(),
        const SizedBox(height: 14),
        const UdhaarSummaryCard(),
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
              const StockTile(
                name: 'Chakki Atta 10kg',
                units: 'Only 3 units left',
                danger: true,
              ),
              const SizedBox(height: 10),
              const StockTile(
                name: 'Cooking Oil 5L',
                units: 'Only 2 units left',
                danger: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
