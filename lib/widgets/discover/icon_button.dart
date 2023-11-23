import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback callback;
  final String labelText;
  final IconData iconData;
  const CustomIconButton({
    super.key,
    required this.callback,
    required this.labelText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: IconButton(
            onPressed: callback,
            icon: Icon(
              iconData,
              color: Colors.white,
            ),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: callback,
          child: Text(
            labelText,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
