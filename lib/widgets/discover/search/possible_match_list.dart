import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:flutter/material.dart';

class PossibleMatchList extends StatelessWidget {
  final String keyword;
  final List<String> possibleMatch;
  final void Function(int index) callback;
  final void Function(int index) openInNew;
  const PossibleMatchList({
    super.key,
    required this.keyword,
    required this.possibleMatch,
    required this.callback,
    required this.openInNew,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: possibleMatch.length,
        itemBuilder: (context, index) {
          final matchedString = possibleMatch[index];
          final subIndex =
              matchedString.toLowerCase().indexOf(keyword.toLowerCase());
          return ListTile(
            onTap: () => callback(index),
            title: RichText(
                text: TextSpan(
              text: matchedString.substring(0, subIndex),
              children: [
                TextSpan(
                  text: matchedString.substring(
                      subIndex, subIndex + keyword.length),
                  style: const TextStyle(color: ColorConstant.themeColor),
                  children: [
                    TextSpan(
                      text: matchedString.substring(subIndex + keyword.length),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
            trailing: IconButton(
              icon: const Icon(Icons.open_in_new_outlined),
              onPressed: () => openInNew(index),
            ),
          );
        },
      ),
    );
  }
}
