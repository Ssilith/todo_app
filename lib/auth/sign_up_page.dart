// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/widgets/form_container.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/widgets/message.dart';
import 'package:todo_app/widgets/rectangular_button.dart';
import 'package:todo_app/widgets/text_input_form.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback callback;
  const SignUpPage({super.key, required this.callback});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthService authService = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    repeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FormContainer(
      title: "Sign up",
      width: 320,
      children: [
        TextInputForm(
          width: size.width * 0.9,
          hint: 'E-mail',
          controller: email,
          iconData: Icons.person,
        ),
        const SizedBox(height: 15),
        TextInputForm(
          width: size.width * 0.9,
          hint: 'Password',
          controller: password,
          hideText: true,
          iconData: Icons.lock,
        ),
        const SizedBox(height: 15),
        TextInputForm(
          width: size.width * 0.9,
          hint: 'Repeat password',
          controller: repeatPassword,
          hideText: true,
          iconData: Icons.lock,
        ),
        const SizedBox(height: 15),
        RectangularButton(
          title: "SIGN UP",
          isLoading: isLoading,
          onPressed: () async {
            String userEmail = email.text;
            String userPassword = password.text;
            String userRepeatPassword = repeatPassword.text;

            try {
              setState(() => isLoading = true);
              await authService.signUp(
                userEmail,
                userPassword,
                userRepeatPassword,
              );
              setState(() => isLoading = false);
              widget.callback();
            } catch (e) {
              setState(() => isLoading = false);
              displayErrorMotionToast("Failed to sing up.", context);
            }
          },
        ),
      ],
    );
  }
}
