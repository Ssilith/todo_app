// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/widgets/message.dart';

class LogoutButton extends StatelessWidget {
  final AuthService authService;
  const LogoutButton({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Ink(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.logout_outlined,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      onPressed: () async {
        try {
          await authService.signOut();
        } catch (e) {
          displayErrorMotionToast('Failed to log out.', context);
        }
      },
    );
  }
}
