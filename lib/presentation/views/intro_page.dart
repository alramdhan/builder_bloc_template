import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/presentation/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("finish_intro", true);
            sl<AppRouter>().pushReplacement(const LoginPage());
          },
          child: const Text("Intro Page")
        ),
      ),
    );
  }
}