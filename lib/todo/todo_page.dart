// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_app/blank_scaffold.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/todo/add_new_todo.dart';
import 'package:todo_app/todo/edit_todo.dart';
import 'package:todo_app/todo/logout_button.dart';
import 'package:todo_app/todo/todo_tile.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoPage extends StatefulWidget {
  final TodoService? todoService;
  const TodoPage({super.key, this.todoService});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  AuthService authService = AuthService();
  ScrollController scrollController = ScrollController();
  TextEditingController newTodoController = TextEditingController();
  late TodoService todoService;
  List<Todo> todos = [];
  int? _editingIndex;
  bool _isAdding = false;

  @override
  void initState() {
    todoService = widget.todoService ?? TodoService();
    _loadTodos();
    super.initState();
  }

  @override
  dispose() {
    newTodoController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadTodos() async {
    final list = await todoService.getAllTodos();
    setState(() => todos = list.reversed.toList());
  }

  Future<void> _addTodo() async {
    final name = newTodoController.text.trim();
    if (name.isEmpty) return;
    await todoService.addTodo(Todo(id: 0, name: name, isComplete: false));
    newTodoController.clear();
    setState(() => _isAdding = false);
    await _loadTodos();
  }

  Future<void> _editTodo(int idx, String newName) async {
    if (newName.trim().isEmpty) return;
    final t = todos[idx]..name = newName;
    await todoService.editTodo(t);
    setState(() => _editingIndex = null);
    await _loadTodos();
  }

  Future<void> _toggleFinished(int idx, bool? v) async {
    final t = todos[idx]..isComplete = v ?? false;
    await todoService.editTodo(t);
    await _loadTodos();
  }

  Future<void> _removeTodo(int idx) async {
    await todoService.deleteTodo(todos[idx].id);
    await _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlankScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _isAdding = true),
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Theme.of(context).primaryColor),
      ),
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: size.width * 0.8,
                constraints: BoxConstraints(maxHeight: size.height * 0.8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Todos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        itemCount: todos.length,
                        itemBuilder: (context, idx) {
                          if (_editingIndex == idx) {
                            final ctrl = TextEditingController(
                              text: todos[idx].name,
                            );
                            return EditTodo(
                              controller: ctrl,
                              onEdit: (val) => _editTodo(idx, val),
                            );
                          }
                          final todo = todos[idx];
                          return TodoTile(
                            todo: todo,
                            toggleFinished: (v) => _toggleFinished(idx, v),
                            onDoubleTap:
                                () => setState(() => _editingIndex = idx),
                            remove: () => _removeTodo(idx),
                          );
                        },
                      ),
                    ),
                    if (_isAdding) ...[
                      const SizedBox(height: 12),
                      AddNewTodo(
                        newTodoController: newTodoController,
                        onAdd: _addTodo,
                        onPressed: () => setState(() => _isAdding = false),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 15,
          child: LogoutButton(authService: authService),
        ),
      ],
    );
  }
}
