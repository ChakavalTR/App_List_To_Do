import 'package:app_list_to_do/screens/add_task_screen.dart';
import 'package:app_list_to_do/screens/task_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isChecked = false;
  int currentIndex = 0;
  List<String> tasks = [];

  void updateTask(int index, String newTask) {
    setState(() {
      tasks[index] = newTask;
    });
  }

  void deletetask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
        title: Text(
          'To-Do List App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String? newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddTaskScreen();
                  },
                ),
              );
              if (newTask != null && newTask.isNotEmpty) {
                setState(() {
                  tasks.add(newTask);
                });
              }
            },
            icon: Icon(Icons.add, size: 35),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.right,
              thickness: 5,
              trackVisibility: true,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  var task = tasks[index];
                  return WidgetContainer(
                    title: task,
                    index: index,
                    onDelete: deletetask,
                    onUpdate: updateTask,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: currentIndex == 0 ? 40 : 25,
                color: currentIndex == 0 ? Colors.amber : null,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
                size: currentIndex == 1 ? 40 : 25,
                color: currentIndex == 1 ? Colors.amber : null,
              ),
              label: 'Work',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: currentIndex == 2 ? 40 : 25,
                color: currentIndex == 2 ? Colors.amber : null,
              ),
              label: 'Profile',
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}

//! Widget Container
class WidgetContainer extends StatefulWidget {
  final String title;
  final int index;
  final Function(int) onDelete;
  final Function(int, String) onUpdate;
  const WidgetContainer({
    super.key,
    required this.title,
    required this.index,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<WidgetContainer> createState() => _WidgetContainerState();
}

class _WidgetContainerState extends State<WidgetContainer> {
  bool? isChecked = false;
  late TextEditingController taskEditingController;

  @override
  void initState() {
    super.initState();
    taskEditingController = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                activeColor: Colors.yellow,
                checkColor: Colors.black,
              ),
            ),
          ),
          Text(
            taskEditingController.text,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          Spacer(),
          IconButton(
            onPressed: () async {
              String updateTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TaskDetailScreen(taskText: taskEditingController.text),
                ),
              );
              if (updateTask.isNotEmpty) {
                widget.onUpdate(widget.index, updateTask);
              }
            },
            icon: Icon(Icons.edit, color: Colors.blueAccent, size: 30),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Delete Task',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    content: Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          widget.onDelete(widget.index);
                          Navigator.pop(context);
                        },
                        child: Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete, size: 35, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
