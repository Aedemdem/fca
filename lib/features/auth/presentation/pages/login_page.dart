import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fca/features/auth/presentation/providers/login_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: loginState.when(
        data: (state) {
          if (state.loginResponse != null) {
            // Navigasi ke halaman berikutnya setelah login berhasil
            Future.microtask(() {
              Navigator.pushReplacementNamed(context, '/home');
            });
            return Container(); // Widget kosong karena kita akan bernavigasi
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(), // Widget untuk form login
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message, _) => Center(
          child: Text(
            'Login failed: $message',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(loginNotifierProvider.notifier).login(
              email: _emailController.text,
              password: _passwordController.text,
            );
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}