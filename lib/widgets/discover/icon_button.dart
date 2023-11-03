import 'package:flutter/material.dart';
import 'package:flutter_bangumi/helpers/sizing_helper.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      width: 18.w,
      child: Column(
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
            ),
          ),
        ],
      ),
    );
  }
}
