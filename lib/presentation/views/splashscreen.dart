import 'dart:async';

import 'package:builder_bloc_template/core/config/router.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/presentation/views/auth/login_page.dart';
import 'package:builder_bloc_template/presentation/views/home/home_page.dart';
import 'package:builder_bloc_template/presentation/views/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth? fAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  Future<Timer> _startSplashScreen() async {
    const duration = Duration(seconds: 5);
    final prefs = await SharedPreferences.getInstance();
    return Timer(duration, () {
      if(fAuth?.currentUser != null) {
        sl<AppRouter>().pushReplacement(const HomePage());
      } else {
        if(!(prefs.getBool("finish_intro") ?? false)) {
          sl<AppRouter>().pushReplacement(const IntroPage());
        } else {
          sl<AppRouter>().pushReplacement(const LoginPage());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("App Splash Screen"),
        ),
      ),
    );
  }
}