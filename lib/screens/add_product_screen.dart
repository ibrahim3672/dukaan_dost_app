import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add New Product'),
        actions: [TextButton(onPressed: () {}, child: const Text('اردو'))],
      ),
      body: AppScroll(
        bottomPadding: 24,
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: C.outlineLight, width: 2),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo_rounded, color: C.outline, size: 46),
                SizedBox(height: 10),
                Text(
                  'Upload Product Photo',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  'تصویر اپ لوڈ کریں',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: C.outline),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const LabeledField(
            label: 'Product Name',
            urdu: 'آئٹم کا نام',
            hint: 'e.g. Basmati Rice',
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(
                child: DropField(
                  label: 'Category',
                  value: 'Grains',
                  options: ['Grains', 'Beverages', 'Dairy', 'Snacks'],
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
            label: 'Initial Stock',
            urdu: 'موجودہ اسٹاک',
            hint: '0.00',
            suffix: 'Available',
            keyboard: TextInputType.number,
          ),
          const SizedBox(height: 14),
          const AppCard(
            color: Color(0x1AACF4A4),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: LabeledField(
                        label: 'Purchase Price',
                        urdu: 'خریداری قیمت',
                        hint: '0',
                        prefix: 'Rs.',
                        keyboard: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: LabeledField(
                        label: 'Sale Price',
                        urdu: 'فروخت قیمت',
                        hint: '0',
                        prefix: 'Rs.',
                        keyboard: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.trending_up_rounded, color: C.primary),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Estimated Profit: Rs. 0.00 / unit',
                        style: TextStyle(
                          color: C.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Add Product',
            icon: Icons.arrow_forward_rounded,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
