import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati_app/core/Services/local_helper.dart';
import 'package:taskati_app/core/constants/app_fonts.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await LocalHelper.init();
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
