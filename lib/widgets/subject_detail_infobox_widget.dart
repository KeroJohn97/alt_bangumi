import 'package:alt_bangumi/models/subject_model/infobox_model.dart';
import 'package:flutter/material.dart';

class SubjectDetailInfoboxWidget extends StatelessWidget {
  final List<InfoboxModel>? infobox;
  const SubjectDetailInfoboxWidget({super.key, required this.infobox});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (infobox != null)
          ...infobox!
              .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('${e.key}: ${e.value}'),
                  ))
              .toList()
      ],
    );
  }
}
