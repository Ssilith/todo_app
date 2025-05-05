import 'package:flutter/material.dart';

class AddNewTodo extends StatelessWidget {
  final TextEditingController newTodoController;
  final VoidCallback onAdd;
  final VoidCallback onPressed;
  const AddNewTodo({
    super.key,
    required this.newTodoController,
    required this.onAdd,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: newTodoController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'New todo',
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (_) => onAdd(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.check, color: Theme.of(context).primaryColor),
          onPressed: onAdd,
        ),
        IconButton(
          icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
