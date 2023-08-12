import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

import 'login_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Todo> todos = [
    Todo(
      title: "heloo",
      description: "vajno",
      completed: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Todo(
      title: "sds",
      description: "vasdsjno",
      completed: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Todo List"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure do you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      },
                      child: const Text("Confirm"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TodoFormPage();
              },
            ),
          );
          setState(() {
            todos.add(result);
          });
        },
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TodoFormPage(
                      todo: todos[index],
                    );
                  },
                ),
              );

              // update
              setState(() {
                todos[index] = result;
              });
            },
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
                setState(() {
                  todos.remove(todos[index]);
                  // todos.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
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
                onPressed: () {
                  if (titleController.text.isEmpty) return;

                  if (widget.todo != null) {
                    // update
                    final todo = Todo(
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
                      title: titleController.text,
                      description: descriptionController.text,
                      completed: false,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
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
