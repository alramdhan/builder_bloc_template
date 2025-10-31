import 'package:builder_bloc_template/core/config/router/app_router.dart';
import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/core/themes/app_theme.dart';
import 'package:builder_bloc_template/firebase_options.dart';
import 'package:builder_bloc_template/presentation/pages/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // serviceLocatorSetup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: sl<AppRouter>().navigatorKey,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: AppTheme.lightColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: AppColor.primary400,
            foregroundColor: AppColor.light,
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColor.light,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.25
            )
          )
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          filled: false
        )
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: AppTheme.darkColorScheme
      ),
      home: const LoginPage(),
    );
  }
}
