import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_theme.dart';
import 'providers/app_state_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/products_provider.dart';
import 'providers/sales_provider.dart';
import 'providers/udhaar_provider.dart';
import 'screens/add_product_screen.dart';
import 'screens/auth_screens.dart';
import 'screens/main_shell.dart';
import 'screens/manual_entry_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';
import 'services/product_service.dart';
import 'services/sales_service.dart';
import 'services/udhaar_service.dart';

void main() => runApp(const DukaanDostApp());

class DukaanDostApp extends StatelessWidget {
  const DukaanDostApp({super.key});

  @override
  Widget build(BuildContext context) {
    final api = DatabaseService();

    return MultiProvider(
      providers: [
        Provider<DatabaseService>.value(value: api),
        Provider<AuthService>(create: (_) => AuthService(api)),
        Provider<ProductService>(create: (_) => ProductService(api)),
        Provider<SalesService>(create: (_) => SalesService(api)),
        Provider<UdhaarService>(create: (_) => UdhaarService(api)),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(AuthService(api)),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => ProductsProvider(ProductService(api)),
        ),
        ChangeNotifierProvider<SalesProvider>(
          create: (_) => SalesProvider(SalesService(api)),
        ),
        ChangeNotifierProvider<UdhaarProvider>(
          create: (_) => UdhaarProvider(UdhaarService(api)),
        ),
        ChangeNotifierProvider<AppStateProvider>(
          create: (_) => AppStateProvider(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
