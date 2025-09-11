import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/core/Services/local_helper.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/features/home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController nameController = TextEditingController();
  String? imagePath;

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  void _saveAndGo() {
    if (nameController.text.trim().isEmpty || imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name and pick an image")),
      );
      return;
    }
    LocalHelper.putUserData(nameController.text.trim(), imagePath!);
    pushWithReplacement(context, const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _saveAndGo,
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Appcolor.primarycolor,
              backgroundImage: imagePath != null
                  ? FileImage(File(imagePath!))
                  : const AssetImage('assets/images/empty user.png') as ImageProvider,
              child: imagePath == null
                  ? const Icon(Icons.person, size: 50, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primarycolor,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50),
              ),
              child: const Text('Upload From Camera'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primarycolor,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50),
              ),
              child: const Text('Upload From Gallery'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Divider(color: Appcolor.bordecolor, thickness: 1),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolor.primarycolor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
