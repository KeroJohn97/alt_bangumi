import 'package:alt_bangumi/models/subject_model/infobox_model.dart';
import 'package:flutter/material.dart';

class SubjectDetailInfoboxWidget extends StatelessWidget {
  final List<InfoboxModel>? infobox;
  const SubjectDetailInfoboxWidget({super.key, required this.infobox});

  String _handleInfoboxValue(InfoboxModel infobox) {
    if (infobox.value is List<dynamic>) {
      final List<dynamic> infoboxList = infobox.value;
      final List<String> value = infoboxList.map((e) => '${e['v']}').toList();
      if (value.isEmpty) return '';
      return '${infobox.key}: ${value.join(', ')}';
    }
    return '${infobox.key}: ${infobox.value}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (infobox != null)
          ...infobox!
              .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _handleInfoboxValue(e),
                      textAlign: TextAlign.center,
                    ),
                  ))
              .toList()
      ],
    );
  }
}
