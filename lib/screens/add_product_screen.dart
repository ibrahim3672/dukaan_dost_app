import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/products_provider.dart';
import '../widgets/common_widgets.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();
  String category = 'Grains';
  String unit = 'kg';

  @override
  void dispose() {
    nameController.dispose();
    stockController.dispose();
    priceController.dispose();
    super.dispose();
  }

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
      body: Consumer<ProductsProvider>(
        builder: (context, provider, _) {
          return AppScroll(
            bottomPadding: 24,
            children: [
              const LabeledField(
                label: 'Product Name',
                urdu: 'آئٹم کا نام',
                hint: 'e.g. Basmati Rice',
              ),
              const SizedBox(height: 14),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Product name'),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _SimpleDropdown(
                      label: 'Category',
                      value: category,
                      options: const ['Grains', 'Beverages', 'Dairy', 'Snacks'],
                      onChanged: (value) => setState(() => category = value),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _SimpleDropdown(
                      label: 'Unit',
                      value: unit,
                      options: const ['kg', 'pcs', 'ltr', 'pack'],
                      onChanged: (value) => setState(() => unit = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Initial stock'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Sale price',
                  prefixText: 'Rs. ',
                ),
              ),
              if (provider.error != null) ...[
                const SizedBox(height: 12),
                ApiStateMessage(message: provider.error!, isError: true),
              ],
              const SizedBox(height: 24),
              PrimaryButton(
                label: provider.isLoading ? 'Saving...' : 'Add Product',
                icon: Icons.arrow_forward_rounded,
                onPressed: provider.isLoading ? () {} : () => _save(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    final created = await context.read<ProductsProvider>().createProduct(
      ProductModel(
        id: 0,
        name: nameController.text.trim(),
        unit: unit,
        category: category,
        stock: double.tryParse(stockController.text) ?? 0,
        salePrice: double.tryParse(priceController.text) ?? 0,
      ),
    );
    if (created != null && context.mounted) Navigator.pop(context);
  }
}

class _SimpleDropdown extends StatelessWidget {
  const _SimpleDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: options
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
