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
          if (sale) ...[
            const LabeledField(
              label: 'Product',
              urdu: 'آئٹم',
              hint: 'Enter product name...',
            ),
            const SizedBox(height: 14),
            Row(
              children: const [
                Expanded(
                  child: LabeledField(
                    label: 'Quantity',
                    urdu: 'مقدار',
                    hint: '0.00',
                    keyboard: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropField(
                    label: 'Unit',
                    value: 'kg',
                    options: ['kg', 'pcs', 'ltr', 'pack'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const LabeledField(
              label: 'Price',
              urdu: 'قیمت',
              hint: '0',
              prefix: 'Rs.',
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 14),
            const LabeledField(
              label: 'Customer',
              urdu: 'گاہک',
              hint: 'Search or add name...',
            ),
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
          ] else ...[
            const LabeledField(
              label: 'Search / Select Item',
              urdu: 'آئٹم منتخب کریں',
              hint: 'Search existing stock item...',
            ),
            const SizedBox(height: 14),
            AppCard(
              color: const Color(0x1AACF4A4),
              child: Row(
                children: const [
                  Icon(Icons.inventory_2_rounded, color: C.primary),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected item unit',
                          style: TextStyle(
                            color: C.outline,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'kg',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(
                      'Auto-filled',
                      style: TextStyle(
                        color: C.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    backgroundColor: Color(0x22387B41),
                    side: BorderSide.none,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const LabeledField(
              label: 'Quantity to Add',
              urdu: 'شامل مقدار',
              hint: '0.00',
              keyboard: TextInputType.number,
            ),
          ],
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
}
