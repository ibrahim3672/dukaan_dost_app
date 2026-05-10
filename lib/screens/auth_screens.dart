import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return AuthScaffold(
          title: 'Welcome back',
          subtitle:
              'Login to sync AI parsed entries with your Laravel Sanctum backend.',
          action: auth.isLoading ? 'Logging in...' : 'Login',
          footer: 'New shop on DukanDost?',
          footerAction: 'Create account',
          error: auth.error,
          onAction: auth.isLoading ? null : () => _login(context),
          onFooter: () => Navigator.pushNamed(context, '/register'),
          children: [
            LabeledField(
              label: 'Email',
              urdu: 'ای میل',
              hint: 'you@example.com',
              keyboard: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(height: 14),
            LabeledField(
              label: 'Password',
              urdu: 'پاس ورڈ',
              hint: 'Enter password',
              obscure: true,
              controller: passwordController,
            ),
          ],
        );
      },
    );
  }

  Future<void> _login(BuildContext context) async {
    final ok = await context.read<AuthProvider>().login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    if (ok && context.mounted) Navigator.pushReplacementNamed(context, '/home');
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ownerController = TextEditingController();
  final shopController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    ownerController.dispose();
    shopController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return AuthScaffold(
          title: 'Create your shop',
          subtitle: 'Set up owner and store details before API integration.',
          action: auth.isLoading ? 'Registering...' : 'Register Shop',
          footer: 'Already registered?',
          footerAction: 'Login',
          error: auth.error,
          onAction: auth.isLoading ? null : () => _register(context),
          onFooter: () => Navigator.pop(context),
          children: [
            LabeledField(
              label: 'Owner Name',
              urdu: 'مالک کا نام',
              hint: 'Ibrahim Arshid',
              controller: ownerController,
            ),
            const SizedBox(height: 14),
            LabeledField(
              label: 'Shop Name',
              urdu: 'دکان کا نام',
              hint: 'Dukaan Dost General Store',
              controller: shopController,
            ),
            const SizedBox(height: 14),
            LabeledField(
              label: 'Email',
              urdu: 'ای میل',
              hint: 'you@example.com',
              keyboard: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(height: 14),
            LabeledField(
              label: 'Phone Number',
              urdu: 'فون نمبر',
              hint: '+92 300 1234567',
              keyboard: TextInputType.phone,
              controller: phoneController,
            ),
            const SizedBox(height: 14),
            LabeledField(
              label: 'Password',
              urdu: 'پاس ورڈ',
              hint: 'Create password',
              obscure: true,
              controller: passwordController,
            ),
          ],
        );
      },
    );
  }

  Future<void> _register(BuildContext context) async {
    final ok = await context.read<AuthProvider>().register(
      name: ownerController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      phone: phoneController.text.trim(),
      shopName: shopController.text.trim(),
    );
    if (ok && context.mounted) Navigator.pushReplacementNamed(context, '/home');
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
    this.error,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final String action;
  final String footer;
  final String footerAction;
  final VoidCallback? onAction;
  final VoidCallback onFooter;
  final String? error;

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
              if (error != null) ...[
                const SizedBox(height: 12),
                Text(
                  error!,
                  style: const TextStyle(
                    color: C.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              const SizedBox(height: 22),
              PrimaryButton(
                label: action,
                icon: Icons.lock_open_rounded,
                onPressed: onAction ?? () {},
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
