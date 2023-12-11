import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final String tag;
  final List<PopupMenuEntry<dynamic>> menuItem;
  final Widget? iconWidget;
  const CustomPopupMenuButton({
    required this.tag,
    required this.menuItem,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
        ),
        child: PopupMenuButton(
          splashRadius: 24.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconWidget != null) iconWidget!,
                Text(
                  tag,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          itemBuilder: (context) {
            return menuItem;
          },
        ),
      ),
    );
  }
}