import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/core/utils/text_style.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  XFile? imageFile; // هنخزن الصورة هنا
  final _controller = TextEditingController(); // هنخزن الاسم هنا

  // دالة لاختيار الصورة
  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        imageFile = picked;
      });
    }
  }

  // دالة زرار Done
  void _onDone() {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك اكتب اسمك")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("اسمك هو: ${_controller.text}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _onDone,
            child: const Text("Done"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة البروفايل
            CircleAvatar(
              radius: 80,
              backgroundColor: Appcolor.primarycolor,
              backgroundImage: imageFile != null
                  ? FileImage(File(imageFile!.path))
                  : const AssetImage('assets/images/empty user.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 20),

            // زرار الكاميرا
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primarycolor,
                foregroundColor: Appcolor.whitecolor,
              ),
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text("Upload From Camera"),
            ),
            const SizedBox(height: 10),

            // زرار المعرض
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primarycolor,
                foregroundColor: Appcolor.whitecolor,
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text("Upload From Gallery"),
            ),
            const SizedBox(height: 20),

            // إدخال الاسم
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter Your Name",
                labelStyle: TextStyles.bodyStyle(color: Appcolor.graycolor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Appcolor.bordecolor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolor.primarycolor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
