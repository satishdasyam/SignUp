import 'package:flutter/material.dart';
import 'package:employee_sign_up/signup_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.signupModel});

  final SignupModel signupModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("HomePage"),
      ),
      body: const Center(
        child: Text("Unique ID"),
      ),
    );
  }
}
