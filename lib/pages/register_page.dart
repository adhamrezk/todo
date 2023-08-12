import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/todo_list_page.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Email',
              ),
              validator: (value) {
                if (_emailController.text.isEmpty) {
                  return "Email can't be empty";
                }
                if (!_emailController.text.isValidEmail()) {
                  return "Email is not valid";
                }

                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Password',
              ),
              validator: (value) {
                if (_passwordController.text.isEmpty) {
                  return "Password can't be empty";
                }
                if (_passwordController.text.length < 6) {
                  return "Password should at least contain 6 characters";
                }

                return null;
              },
            ),
            TextFormField(
              controller: _passwordConfirmController,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
              validator: (value) {
                if (_passwordConfirmController.text !=
                    _passwordController.text) {
                  return "Password didn't match";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // send data
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TodoListPage(),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: const Text("Regitser"),
            ),
          ],
        ),
      ),
    );
  }
}

// basic ui
// 2 input(textfields)
// 2-(3) button to submit

// functionality
// auth -> email and password no need for database

// basic ui
// 2 input(textfields)
// 2-(3) button to submit

// functionality
// auth -> email and password no need for database
// basic ui
// 2 input(textfields)
// 2-(3) button to submit

// functionality
// auth -> email and password no need for database
// auth -> email and password no need for database
// auth -> email and password no need for database
// auth -> email and password no need for database
