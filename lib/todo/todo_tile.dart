import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final Function(bool?) toggleFinished;
  final VoidCallback remove;
  final VoidCallback onDoubleTap;
  const TodoTile({
    super.key,
    required this.todo,
    required this.toggleFinished,
    required this.remove,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onDoubleTap: onDoubleTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: todo.isComplete,
                onChanged: (v) => toggleFinished(v),
                fillColor: WidgetStateProperty.all(
                  todo.isComplete
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  todo.name,
                  style: TextStyle(
                    color:
                        todo.isComplete
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                    decoration:
                        todo.isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                onPressed: remove,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
