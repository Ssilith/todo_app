import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChangeViewButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback callback;
  const ChangeViewButton({
    super.key,
    required this.isLogin,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: callback,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isLogin ? MdiIcons.lockReset : MdiIcons.login,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            isLogin ? 'DONT\'T HAVE AN ACCOUNT?' : 'WANT TO LOG IN?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
