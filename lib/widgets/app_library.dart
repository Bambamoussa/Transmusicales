import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  String title;
  FormTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: const TextStyle(
          color: Colors.deepPurple,
          fontSize: 18
      ),
    );
  }
}

class MyPadding extends StatelessWidget {
  Widget child;
  MyPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}

class BottomButtons extends StatelessWidget {
  final void Function() onValidate;
  final void Function() onCancel;

  BottomButtons({required this.onValidate, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(onPressed: onCancel, child: const Text("Annuler")),
        ElevatedButton(onPressed: onValidate, child: const Text("Valider"))
      ],
    );
  }
}

class AuthTextField extends StatelessWidget {
  final String authValue;
  final TextEditingController controller;
  AuthTextField({required this.authValue, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: authValue, border: OutlineInputBorder()),
      validator: (newValue) {
        (newValue!.isEmpty) ? const Text("veuillez renseigner ce champ", style: TextStyle(color: Colors.red),) : null;
      },
    );
  }
}