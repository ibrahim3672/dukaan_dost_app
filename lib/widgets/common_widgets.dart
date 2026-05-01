import 'package:flutter/material.dart';

import '../app/app_theme.dart';

class BrandAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrandAppBar({super.key, this.onSettings, this.showSettings = true});
  final VoidCallback? onSettings;
  final bool showSettings;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const BrandMark(compact: true),
      actions: [
        TextButton(onPressed: () {}, child: const Text('EN/اردو')),
        if (showSettings)
          IconButton(
            onPressed: onSettings,
            icon: const Icon(Icons.settings_rounded),
          ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: const Color(0xFFE7E7E7)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 32 : 52,
          height: compact ? 32 : 52,
          decoration: BoxDecoration(
            color: compact ? Colors.transparent : C.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.storefront_rounded,
            color: compact ? C.primary : Colors.white,
            size: compact ? 25 : 28,
          ),
        ),
        SizedBox(width: compact ? 8 : 12),
        const Text(
          'DukanDost',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: C.primary,
          ),
        ),
      ],
    );
  }
}

class DukanBottomNav extends StatelessWidget {
  const DukanBottomNav({
    super.key,
    required this.index,
    required this.onChanged,
  });
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.dashboard_rounded, 'Dashboard'),
      (Icons.receipt_long_rounded, 'Udhaar'),
      (Icons.mic_rounded, 'Voice'),
      (Icons.inventory_2_rounded, 'Stock'),
      (Icons.bar_chart_rounded, 'Reports'),
    ];
    return Container(
      height: 86,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final active = i == index;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFFE8F6E7) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i].$1,
                      color: active ? C.primary : const Color(0xFF78716C),
                      size: 23,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[i].$2,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w900 : FontWeight.w600,
                        color: active ? C.primary : const Color(0xFF78716C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class AppScroll extends StatelessWidget {
  const AppScroll({
    super.key,
    required this.children,
    this.bottomPadding = 108,
  });
  final List<Widget> children;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 20, 16, bottomPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.border,
  });
  final Widget child;
  final Color color;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        border: border ?? Border.all(color: const Color(0x0D000000)),
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: C.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(56),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
      ),
    );
  }
}

class LabeledField extends StatelessWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.urdu,
    required this.hint,
    this.prefix,
    this.suffix,
    this.keyboard,
    this.obscure = false,
  });
  final String label;
  final String urdu;
  final String hint;
  final String? prefix;
  final String? suffix;
  final TextInputType? keyboard;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: C.muted,
                fontWeight: FontWeight.w900,
              ),
            ),
            Flexible(
              child: Text(
                urdu,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: C.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscure,
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix == null ? null : '$prefix ',
            suffixText: suffix,
          ),
        ),
      ],
    );
  }
}

class DropField extends StatelessWidget {
  const DropField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
  });
  final String label;
  final String value;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: C.muted, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: options
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: (_) {},
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          ),
        ),
      ],
    );
  }
}

class Segment extends StatelessWidget {
  const Segment({
    super.key,
    required this.left,
    required this.right,
    required this.leftActive,
    required this.onChanged,
  });
  final String left;
  final String right;
  final bool leftActive;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: C.surfaceHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: SegmentButton(
              label: left,
              active: leftActive,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: SegmentButton(
              label: right,
              active: !leftActive,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class SegmentButton extends StatelessWidget {
  const SegmentButton({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
  });
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: active
              ? const [BoxShadow(color: Color(0x12000000), blurRadius: 8)]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active ? C.primary : C.muted,
            fontWeight: active ? FontWeight.w900 : FontWeight.w600,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.hint});
  final String hint;

  @override
  Widget build(BuildContext context) => TextField(
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: const Icon(Icons.search_rounded, color: C.outline),
    ),
  );
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.action});
  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
      if (action != null)
        Text(
          action!,
          style: const TextStyle(color: C.primary, fontWeight: FontWeight.w900),
        ),
    ],
  );
}

class QuickAction extends StatelessWidget {
  const QuickAction(
    this.title,
    this.subtitle,
    this.icon,
    this.color, {
    super.key,
    this.darkText = false,
    this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool darkText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = darkText ? C.text : Colors.white;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: shadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w900),
            ),
            Text(
              subtitle,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: textColor.withAlpha(220),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard(this.title, this.value, this.icon, this.color, {super.key});
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: C.outline,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class StockTile extends StatelessWidget {
  const StockTile({
    super.key,
    required this.name,
    required this.units,
    this.danger = false,
  });
  final String name;
  final String units;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.surfaceLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: danger ? C.errorContainer : C.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              danger ? Icons.warning_rounded : Icons.inventory_2_rounded,
              color: danger ? C.error : C.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                Text(
                  units,
                  style: const TextStyle(color: C.outline, fontSize: 12),
                ),
              ],
            ),
          ),
          Chip(
            label: Text(
              danger ? 'REORDER' : 'OK',
              style: TextStyle(
                color: danger ? C.error : C.secondary,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
            backgroundColor: danger
                ? const Color(0x14BA1A1A)
                : const Color(0x1A2A6B2C),
            side: BorderSide.none,
          ),
        ],
      ),
    );
  }
}

class SaleTile extends StatelessWidget {
  const SaleTile({
    super.key,
    required this.customer,
    required this.product,
    required this.quantity,
    required this.amount,
    required this.time,
    required this.paymentType,
    this.isUdhaar = false,
  });

  final String customer;
  final String product;
  final String quantity;
  final String amount;
  final String time;
  final String paymentType;
  final bool isUdhaar;

  @override
  Widget build(BuildContext context) {
    final statusColor = isUdhaar ? C.error : C.secondary;
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(28),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.shopping_cart_checkout_rounded,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$customer • $quantity',
                  style: const TextStyle(
                    color: C.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: C.outline, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(24),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  paymentType,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UdhaarCustomer extends StatelessWidget {
  const UdhaarCustomer({
    super.key,
    required this.name,
    required this.amount,
    required this.note,
  });
  final String name;
  final String amount;
  final String note;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: C.secondaryContainer,
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: C.secondary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(note, style: const TextStyle(color: C.outline)),
                  ],
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  color: C.error,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send_rounded),
            label: const Text('Send WhatsApp Reminder'),
            style: FilledButton.styleFrom(
              backgroundColor: C.whatsapp,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.name,
    required this.phone,
    required this.balance,
    required this.status,
    this.hasDebt = false,
  });

  final String name;
  final String phone;
  final String balance;
  final String status;
  final bool hasDebt;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: hasDebt ? C.errorContainer : C.secondaryContainer,
            child: Text(
              name[0],
              style: TextStyle(
                color: hasDebt ? C.error : C.secondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  phone,
                  style: const TextStyle(color: C.outline, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    color: hasDebt ? C.error : C.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                balance,
                style: TextStyle(
                  color: hasDebt ? C.error : C.secondary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.chevron_right_rounded, color: C.outline),
            ],
          ),
        ],
      ),
    );
  }
}

class AddCustomerSheet extends StatelessWidget {
  const AddCustomerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: C.bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 46,
                    height: 5,
                    decoration: BoxDecoration(
                      color: C.outlineLight,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: C.secondaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1_rounded,
                        color: C.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add New Customer',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'گاہک کی تفصیلات شامل کریں',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: C.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const LabeledField(
                  label: 'Customer Name',
                  urdu: 'گاہک کا نام',
                  hint: 'e.g. Ahmed Khan',
                ),
                const SizedBox(height: 14),
                const LabeledField(
                  label: 'Phone Number',
                  urdu: 'فون نمبر',
                  hint: '+92 300 1234567',
                  keyboard: TextInputType.phone,
                ),
                const SizedBox(height: 14),
                const LabeledField(
                  label: 'Opening Udhaar',
                  urdu: 'ابتدائی ادھار',
                  hint: '0',
                  prefix: 'Rs.',
                  keyboard: TextInputType.number,
                ),
                const SizedBox(height: 14),
                const LabeledField(
                  label: 'Address / Note',
                  urdu: 'پتہ یا نوٹ',
                  hint: 'Optional',
                ),
                const SizedBox(height: 22),
                PrimaryButton(
                  label: 'Save Customer',
                  icon: Icons.check_circle_rounded,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile(this.icon, this.title, this.subtitle, {super.key});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: C.primary),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right_rounded),
  );
}

class SalesCard extends StatelessWidget {
  const SalesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payments_rounded, color: C.secondary),
              Spacer(),
              Text(
                'آج کی فروخت',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: C.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Today's Sales",
            style: TextStyle(
              color: C.outline,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Rs. 42,500',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 20),
          MiniBars(),
        ],
      ),
    );
  }
}

class UdhaarSummaryCard extends StatelessWidget {
  const UdhaarSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history_edu_rounded, color: C.error),
              SizedBox(width: 10),
              Text(
                'Total Udhaar',
                style: TextStyle(color: C.outline, fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                'کل ادھار',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: C.error,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Rs. 18,240',
            style: TextStyle(
              color: C.error,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.group_rounded, color: C.outline, size: 18),
              SizedBox(width: 8),
              Text('12 Pending Customers', style: TextStyle(color: C.outline)),
            ],
          ),
        ],
      ),
    );
  }
}

class MiniBars extends StatelessWidget {
  const MiniBars({super.key, this.large = false});
  final bool large;

  @override
  Widget build(BuildContext context) {
    final bars = [0.42, 0.62, 0.74, 1.0, 0.34, 0.55, 0.68];
    return Container(
      height: large ? 160 : 92,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: C.surfaceLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bars.map((height) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: FractionallySizedBox(
                heightFactor: height,
                child: Container(
                  decoration: BoxDecoration(
                    color: height == 1.0
                        ? C.secondary
                        : const Color(0x4DACF4A4),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class OnboardItem extends StatelessWidget {
  const OnboardItem(this.icon, this.title, this.urdu, this.text, {super.key});
  final IconData icon;
  final String title;
  final String urdu;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 148,
          height: 148,
          decoration: BoxDecoration(
            color: C.secondaryContainer.withAlpha(102),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: C.primary, size: 70),
        ),
        const SizedBox(height: 30),
        Text(
          urdu,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: C.primary,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 14),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: C.muted, height: 1.5),
        ),
      ],
    );
  }
}

class Dots extends StatelessWidget {
  const Dots({super.key, required this.count, required this.active});
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => Container(
          width: i == active ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: i == active ? C.primary : C.outlineLight,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class Blob extends StatelessWidget {
  const Blob({super.key, required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
