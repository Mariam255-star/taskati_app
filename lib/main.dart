import 'package:flutter/material.dart';
import 'package:taskati_app/core/constants/app_fonts.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Appcolor.whitecolor,
        fontFamily: AppFonts.poppinsFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Appcolor.whitecolor,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
