import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final VoidCallback? onPressed;

  ///
  ///
  ///
  const MyButton({
    required this.label,
    required this.iconData,
    super.key,
    this.onPressed,
  });

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(label)],
        ),
      ),
      icon: Icon(iconData, size: 20),
    );
  }
}
