import 'package:flutter/material.dart';
import 'package:todo_app/auth/login_page.dart';
import 'package:todo_app/auth/sign_up_page.dart';
import 'package:todo_app/blank_scaffold.dart';
import 'package:todo_app/widgets/change_view_button.dart';

class LoginPageTemplate extends StatefulWidget {
  const LoginPageTemplate({super.key});

  @override
  State<LoginPageTemplate> createState() => _LoginPageTemplateState();
}

class _LoginPageTemplateState extends State<LoginPageTemplate>
    with TickerProviderStateMixin {
  // general animation controller
  late AnimationController animationController;
  // slide out of screen
  late Animation<Offset> slideOutAnimation;
  // slide into screen
  late Animation<Offset> slideInAnimation;
  // login or register screen
  bool isLogin = true;

  @override
  void initState() {
    super.initState();
    // animation duration
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // slide out
    slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.5, 0.0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    // slide in
    slideInAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    // change screens
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => isLogin = !isLogin);
        animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    // _meshController.dispose();
    animationController.dispose();
    super.dispose();
  }

  // run animation
  toggleForm() {
    if (!animationController.isAnimating) {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlankScaffold(
      children: [
        // animated forms
        Center(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              Offset offset =
                  animationController.value < 0.5
                      ? slideOutAnimation.value * size.width
                      : slideInAnimation.value * size.width;
              return Transform.translate(
                offset: offset,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Builder(
                    builder: (context) {
                      if (animationController.value < 0.5) {
                        return (isLogin
                            ? LoginPage(callback: toggleForm)
                            : SignUpPage(callback: toggleForm));
                      } else {
                        return (isLogin
                            ? SignUpPage(callback: toggleForm)
                            : LoginPage(callback: toggleForm));
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: ChangeViewButton(isLogin: isLogin, callback: toggleForm),
        ),
      ],
    );
  }
}
