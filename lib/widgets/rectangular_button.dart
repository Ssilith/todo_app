import 'package:flutter/material.dart';
import 'package:todo_app/widgets/loading.dart';

class RectangularButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  const RectangularButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size.fromHeight(45),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? Loading() : Text(title),
    );
  }
}
