import 'package:builder_bloc_template/core/config/router/app_router.dart';
import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/core/themes/app_theme.dart';
import 'package:builder_bloc_template/presentation/views/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform
  );
  serviceLocatorSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String fontFamily = "Montserrat";
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: sl<AppRouter>().navigatorKey,
      themeMode: ThemeMode.system,
      theme: ThemeData(fontFamily: fontFamily).copyWith(
        brightness: Brightness.light,
        colorScheme: AppTheme.lightColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: AppColor.primary400,
            foregroundColor: AppColor.light,
            elevation: 5,
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColor.light,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.25
            )
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintStyle: TextStyle(color: Colors.blueGrey.shade300),
          filled: false,
        )
      ),
      darkTheme: ThemeData(fontFamily: fontFamily).copyWith(
        brightness: Brightness.dark,
        colorScheme: AppTheme.darkColorScheme,
      ),
      home: const LoginPage(),
    );
  }
}
