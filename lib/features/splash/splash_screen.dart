import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taskati_app/core/Services/local_helper.dart';
import 'package:taskati_app/core/functions/navigation.dart';
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
    Timer(const Duration(milliseconds: 800), _navigateNext);
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
