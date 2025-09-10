import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/core/Services/local_helper.dart';
import 'package:taskati_app/core/utils/colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String path = '';
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (path.isNotEmpty && nameController.text.isNotEmpty) {
                LocalHelper.putUserData(nameController.text, path);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Saved Successfully!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter name and image')),
                );
              }
            },
            child: const Text('Done'),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Appcolor.primarycolor,
            backgroundImage:
                path.isNotEmpty ? Image.file(File(path)).image : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                setState(() {
                  path = pickedFile.path;
                });
              }
            },
            child: const Text('Upload From Camera'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  path = pickedFile.path;
                });
              }
            },
            child: const Text('Upload From Gallery'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Enter Your Name',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
