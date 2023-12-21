import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final VoidCallback callback;
  final IconData iconData;
  final NavigationEnum navigationEnum;
  const CustomIconButton({
    super.key,
    required this.callback,
    required this.iconData,
    required this.navigationEnum,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
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
            onPressed: widget.callback,
            icon: Icon(
              widget.iconData,
              color: Colors.white,
            ),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: widget.callback,
          child: Text(
            widget.navigationEnum.getString(context),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
