import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati_app/core/Services/local_helper.dart';
import 'package:taskati_app/core/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tasks = [];

  @override
  void initState() {
    super.initState();
    tasks = LocalHelper.getTasks();
  }

  void addTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Task Title"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Task Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descController.text.isNotEmpty) {
                LocalHelper.addTask(
                    titleController.text, descController.text);
                setState(() {
                  tasks = LocalHelper.getTasks();
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? name = LocalHelper.getData(LocalHelper.kName);
    final String? imagePath = LocalHelper.getData(LocalHelper.kImage);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, ${name ?? "User"}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.primarycolor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Have A Nice Day.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: (imagePath != null && imagePath.isNotEmpty)
                        ? FileImage(File(imagePath))
                        : const AssetImage("assets/images/empty user.png")
                            as ImageProvider,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Add Task Button
              ElevatedButton(
                onPressed: addTaskDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.primarycolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("+ Add Task"),
              ),

              const SizedBox(height: 20),

              // Task List
              Expanded(
                child: tasks.isEmpty
                    ? const Center(child: Text("No Tasks Added"))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return TaskCard(
                            title: task["title"],
                            desc: task["desc"],
                            time: "No Time",
                            color: Colors.teal,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String time;
  final String desc;
  final Color color;

  const TaskCard({
    super.key,
    required this.title,
    required this.time,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Text(desc,
              style: const TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}
