import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskText;
  const TaskDetailScreen({super.key, required this.taskText});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController taskEditingController;

  @override
  void initState() {
    super.initState();
    taskEditingController = TextEditingController(text: widget.taskText);
  }

  @override
  void dispose() {
    taskEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
        title: Text(
          'Task Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  controller: taskEditingController,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 380,
            child: ElevatedButton(
              onPressed: () {
                SnackBar snackBar = SnackBar(
                  content: Text(
                    '${taskEditingController.text} has been updated!',
                  ),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                String updatedTask = taskEditingController.text;
                if (updatedTask.isNotEmpty) {
                  Navigator.pop(context, updatedTask);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                side: BorderSide(color: Colors.black, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Save Edit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
