import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  const MyButton({super.key,required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
    child:child,
    );
  }
}
