import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/presentation/views/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _fAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _fAuth.currentUser;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user?.email ?? ""),
            TextButton(
              onPressed: () {
                _fAuth.signOut();
                sl<AppRouter>().push(const LoginPage());
              },
              child: const Text("Keluar"),
            )
          ],
        ),
      ),
    );
  }
}