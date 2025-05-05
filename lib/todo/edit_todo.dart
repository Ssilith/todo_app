import 'package:flutter/material.dart';

class EditTodo extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onEdit;
  const EditTodo({super.key, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: (val) => onEdit(val),
              decoration: InputDecoration(
                hintText: 'Edit todo',
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.check, color: Theme.of(context).primaryColor),
            onPressed: () => onEdit(controller.text),
          ),
        ],
      ),
    );
  }
}
