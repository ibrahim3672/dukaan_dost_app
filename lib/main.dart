import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const DukaanDostApp());

class C {
  static const primary = Color(0xFF0D631B);
  static const primaryContainer = Color(0xFF2E7D32);
  static const secondary = Color(0xFF2A6B2C);
  static const secondaryContainer = Color(0xFFACF4A4);
  static const tertiary = Color(0xFF1D622B);
  static const tertiaryContainer = Color(0xFF387B41);
  static const bg = Color(0xFFF9F9F9);
  static const surface = Colors.white;
  static const surfaceLow = Color(0xFFF3F3F3);
  static const surfaceHigh = Color(0xFFE8E8E8);
  static const surfaceHighest = Color(0xFFE2E2E2);
  static const text = Color(0xFF1A1C1C);
  static const muted = Color(0xFF40493D);
  static const outline = Color(0xFF707A6C);
  static const outlineLight = Color(0xFFBFCABA);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const whatsapp = Color(0xFF25D366);
}

const shadow = [
  BoxShadow(color: Color(0x12000000), blurRadius: 16, offset: Offset(0, 6)),
];

class DukaanDostApp extends StatelessWidget {
  const DukaanDostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DukanDost',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: C.primary,
          primary: C.primary,
          secondary: C.secondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: C.surface,
          foregroundColor: C.primary,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: C.primary,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: C.surface,
          hintStyle: const TextStyle(color: C.outline),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: C.outlineLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: C.outlineLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: C.primaryContainer, width: 2),
          ),
        ),
      ),
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const MainShell(),
        '/manual': (_) => const ManualEntryScreen(),
        '/add-product': (_) => const AddProductScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1300), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [C.primary, C.tertiaryContainer],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              right: -70,
              top: -70,
              child: Blob(size: 230, color: Colors.white12),
            ),
            const Positioned(
              left: -90,
              bottom: -70,
              child: Blob(size: 260, color: Colors.white10),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 108,
                    height: 108,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: shadow,
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: C.primary,
                      size: 58,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'DukanDost',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aap ki dukan ka smart hisaab',
                    style: TextStyle(
                      color: Color(0xFFD9FFD5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int page = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const items = [
      OnboardItem(
        Icons.mic_rounded,
        'Voice se hisaab rakhein',
        'آواز سے حساب رکھیں',
        'Speak sales, purchases, and udhaar naturally. Gemini can turn your sentence into clean JSON.',
      ),
      OnboardItem(
        Icons.receipt_long_rounded,
        'Track udhaar easily',
        'ادھار آسانی سے ٹریک کریں',
        'See pending customers, send reminders, and never lose handwritten notes again.',
      ),
      OnboardItem(
        Icons.bar_chart_rounded,
        'Reports at a glance',
        'ماہانہ رپورٹ دیکھیں',
        'Daily sales, low-stock alerts, and monthly snapshots stay ready when you need them.',
      ),
    ];

    return Scaffold(
      appBar: const BrandAppBar(showSettings: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) => setState(() => page = value),
                  children: items,
                ),
              ),
              Dots(count: items.length, active: page),
              const SizedBox(height: 22),
              PrimaryButton(
                label: page == items.length - 1 ? 'Get Started' : 'Next',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  if (page == items.length - 1) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOut,
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
                child: const Text(
                  'Skip for now',
                  style: TextStyle(
                    color: C.outline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome back',
      subtitle:
          'Login to sync AI parsed entries with your Laravel Sanctum backend.',
      action: 'Login',
      footer: 'New shop on DukanDost?',
      footerAction: 'Create account',
      onAction: () => Navigator.pushReplacementNamed(context, '/home'),
      onFooter: () => Navigator.pushNamed(context, '/register'),
      children: const [
        LabeledField(
          label: 'Phone Number',
          urdu: 'فون نمبر',
          hint: '+92 300 1234567',
          keyboard: TextInputType.phone,
        ),
        SizedBox(height: 14),
        LabeledField(
          label: 'Password',
          urdu: 'پاس ورڈ',
          hint: 'Enter password',
          obscure: true,
        ),
      ],
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Create your shop',
      subtitle: 'Set up owner and store details before API integration.',
      action: 'Register Shop',
      footer: 'Already registered?',
      footerAction: 'Login',
      onAction: () => Navigator.pushReplacementNamed(context, '/home'),
      onFooter: () => Navigator.pop(context),
      children: const [
        LabeledField(
          label: 'Owner Name',
          urdu: 'مالک کا نام',
          hint: 'Ibrahim Arshid',
        ),
        SizedBox(height: 14),
        LabeledField(
          label: 'Shop Name',
          urdu: 'دکان کا نام',
          hint: 'Dukaan Dost General Store',
        ),
        SizedBox(height: 14),
        LabeledField(
          label: 'Phone Number',
          urdu: 'فون نمبر',
          hint: '+92 300 1234567',
          keyboard: TextInputType.phone,
        ),
        SizedBox(height: 14),
        LabeledField(
          label: 'Password',
          urdu: 'پاس ورڈ',
          hint: 'Create password',
          obscure: true,
        ),
      ],
    );
  }
}

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    required this.action,
    required this.footer,
    required this.footerAction,
    required this.onAction,
    required this.onFooter,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final String action;
  final String footer;
  final String footerAction;
  final VoidCallback onAction;
  final VoidCallback onFooter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              const BrandMark(),
              const SizedBox(height: 42),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(color: C.muted, height: 1.45),
              ),
              const SizedBox(height: 26),
              AppCard(child: Column(children: children)),
              const SizedBox(height: 22),
              PrimaryButton(
                label: action,
                icon: Icons.lock_open_rounded,
                onPressed: onAction,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(footer, style: const TextStyle(color: C.outline)),
                  TextButton(onPressed: onFooter, child: Text(footerAction)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class VoiceEntryScreen extends StatelessWidget {
  const VoiceEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScroll(
      children: [
        AppCard(
          child: Column(
            children: [
              const Text(
                'Recognized Text',
                style: TextStyle(
                  color: C.secondary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 120),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: C.surfaceLow,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: C.outlineLight),
                ),
                child: const Center(
                  child: Text(
                    'احمد نے 2 کلو آٹا لیا 200 روپے میں',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, height: 1.6, color: C.muted),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 44),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 210,
                height: 210,
                decoration: const BoxDecoration(
                  color: Color(0x1A2E7D32),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 170,
                height: 170,
                decoration: const BoxDecoration(
                  color: Color(0x262E7D32),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: C.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: C.primary.withAlpha(82),
                      blurRadius: 38,
                      spreadRadius: 12,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic_rounded,
                  color: Colors.white,
                  size: 68,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'بولیں: "احمد نے 2 کلو آٹا لیا 200 روپے میں"',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: C.primary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Say: "Ahmed bought 2kg flour for 200 rupees"',
          textAlign: TextAlign.center,
          style: TextStyle(color: C.outline, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Center(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/manual'),
            icon: const Icon(Icons.keyboard_rounded),
            label: const Text('Manual Entry'),
          ),
        ),
        const SizedBox(height: 26),
        PrimaryButton(
          label: 'Confirm Selection',
          icon: Icons.check_circle_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}

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

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const AppScroll(
        bottomPadding: 24,
        children: [
          AppCard(
            child: Column(
              children: [
                SettingTile(
                  Icons.language_rounded,
                  'Language',
                  'English / اردو',
                ),
                Divider(),
                SettingTile(
                  Icons.cloud_sync_rounded,
                  'Laravel API',
                  'Sanctum backend connection',
                ),
                Divider(),
                SettingTile(
                  Icons.auto_awesome_rounded,
                  'Gemini Parsing',
                  'Voice and text AI extraction',
                ),
                Divider(),
                SettingTile(
                  Icons.security_rounded,
                  'Privacy',
                  'Local permissions and account security',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
