import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../widgets/common_widgets.dart';

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
