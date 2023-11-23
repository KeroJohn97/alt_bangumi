import 'package:flutter/material.dart';

class CustomTagWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String tag;
  final int? count;
  const CustomTagWidget({
    super.key,
    required this.onPressed,
    required this.tag,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
      child: SizedBox(
        height: 24.0,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(4.0),
          ),
          child: Text.rich(
            TextSpan(
              text: tag,
              children: [
                TextSpan(
                    text: ' $count',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                    )),
              ],
            ),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
