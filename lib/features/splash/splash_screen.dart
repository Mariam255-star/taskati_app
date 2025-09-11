import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/core/Services/local_helper.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/utils/text_style.dart';
import 'package:taskati_app/features/Upload/upload_page.dart';
import 'package:taskati_app/features/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), _navigateNext);
  }

  void _navigateNext() {
    final dynamic isUploaded = LocalHelper.getData(LocalHelper.kIsUploaded);
    final bool uploaded = isUploaded == true;
    if (uploaded) {
      pushWithReplacement(context, const HomeScreen());
    } else {
      pushWithReplacement(context, const UploadScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/logo.json' , 
            width: 250
            ),
            Gap(15),
            Text('Taskati',
            style: TextStyles.bodyStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(15),
          Text('It\'s Time to get organization' , 
          style: TextStyles.smallStyle(
            fontSize: 16,
          ),
          )
          ],
        ),
      ),
    );
  }
}
