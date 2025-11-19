import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:pf_shop/screens/login.dart';
import 'package:pf_shop/screens/register.dart';
import 'package:pf_shop/screens/menu.dart';
import 'package:pf_shop/screens/product_form.dart';
// import 'package:pf_shop/screens/product_list.dart'; // Jika ada

void main() {
  runApp(
    Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, // Base color
        ).copyWith(
          primary: Colors.green.shade700, // Primary color
          secondary: Colors.greenAccent[400], // Accent color
        ),
        useMaterial3: true,
      ),
      // Mulai dari halaman login
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const MyHomePage(),
        '/add-product': (context) => const ProductFormPage(),
      },
    );
  }
}