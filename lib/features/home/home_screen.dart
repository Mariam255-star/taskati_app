import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati_app/core/Services/local_helper.dart';
import 'package:taskati_app/core/functions/navigation.dart';
import 'package:taskati_app/core/utils/colors.dart';
import 'package:taskati_app/features/addTask/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    tasks = LocalHelper.getTasks();
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final t = titleController.text.trim();
              final d = descController.text.trim();
              if (t.isNotEmpty && d.isNotEmpty) {
                LocalHelper.addTask(t, d);
                setState(() {
                  tasks = LocalHelper.getTasks();
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? name = LocalHelper.getData(LocalHelper.kName) as String?;
    final String? image = LocalHelper.getData(LocalHelper.kImage) as String?;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolor.whitecolor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Appcolor.primarycolor,
              backgroundImage: (image != null && image.isNotEmpty)
                  ? FileImage(File(image))
                  : const AssetImage('assets/images/empty user.png') as ImageProvider,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome 👋', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(name ?? 'User', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Today's Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text('No Tasks Added'))
                  : ListView.separated(
                      itemCount: tasks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final t = tasks[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Appcolor.primarycolor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline, color: Colors.black54),
                              const SizedBox(width: 10),
                              Expanded(child: Text(t['title'] ?? 'No Title', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          pushTo(context, const AddTaskPage());
        },
        backgroundColor: Appcolor.primarycolor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
