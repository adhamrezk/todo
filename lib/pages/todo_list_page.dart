import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late List<Todo> todos = []; // Initialize an empty list

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection("Todo")
          .where('uid', isEqualTo: currentUser.uid)
          .get();

      var tasks =
          querySnapshot.docs.map((doc) => Todo.(doc.data())).toList();

      setState(() {
        todos = todos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... existing code

      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            subtitle: Text(todos[index].description ?? "no description"),
            leading: Checkbox(
              value: todos[index].completed,
              onChanged: (v) {
                setState(() {
                  todos[index].completed = v!;
                });
              },
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                deleteTask(todos[index].uid);
              },
            ),
          );
        },
      ),
    );
  }

  void deleteTask(String taskId) async {
    await FirebaseFirestore.instance.collection("Todo").doc(taskId).delete();
    fetchTasks(); // Refresh the task list
  }
}


class TodoFormPage extends StatefulWidget {
  final Todo? todo;
  const TodoFormPage({super.key, this.todo});

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  // controllers
  late final titleController = TextEditingController(
    text: widget.todo?.title,
  );
  late final descriptionController = TextEditingController(
    text: widget.todo?.description,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo != null ? "Update Todo" : "Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              // title
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              // desc
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  label: Text("Description"),
                ),
              ),
              // save
              ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty) return;

                  if (widget.todo != null) {
                    // update
                    final todo = Todo(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      title: titleController.text,
                      description: descriptionController.text,
                      completed: widget.todo!.completed,
                      createdAt: widget.todo!.createdAt,
                      updatedAt: DateTime.now(),
                    );
                    Navigator.pop(context, todo);
                  } else {
                    // create
                    final todo = Todo(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      title: titleController.text,
                      description: descriptionController.text,
                      completed: false,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    await FirebaseFirestore.instance.collection("Todo").add(
                          todo.toMap(),
                        );
                    Navigator.pop(context, todo);
                  }
                },
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
  //actually it's bullshit