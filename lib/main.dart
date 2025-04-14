import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fca/core/di/injection.dart' as di;
import 'package:fca/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ProviderScope( // Bungkus MyApp dengan ProviderScope
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login', // Setel rute awal ke '/login'
      routes: {
        '/login': (context) => const LoginPage(), // Definisikan rute untuk '/login'
        // ... Rute lainnya (akan ditambahkan nanti)
      },
      // ... Konfigurasi lainnya
    );
  }
}