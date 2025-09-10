import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:gap/gap.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/utils/text_style.dart';
import 'package:taskati_app/features/upload/upload_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      pushWithReplacement(context, const UploadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/logo.json'),
            const Gap(15),
            Text(
              'Taskati',
              style: TextStyles.titleStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(15),
            Text(
              'It\'s time to get organizen',
              style: TextStyles.smallStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
