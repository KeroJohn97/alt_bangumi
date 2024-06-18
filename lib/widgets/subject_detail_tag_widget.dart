import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/screens/tag/single_tag_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/subject_model/tag_model.dart';
import 'custom_tag_widget.dart';

class SubjectDetailTagWidget extends StatelessWidget {
  final List<TagModel>? tags;
  final ScreenSubjectOption subjectOption;
  const SubjectDetailTagWidget({
    super.key,
    required this.tags,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if (tags == null) const SizedBox(height: 8.0),
        if (tags != null)
          ...tags!.map(
            (e) => CustomTagWidget(
              onPressed: () {
                context.push(
                  SingleTagScreen.route,
                  extra: {
                    SingleTagScreen.tagKey: e.name,
                    SingleTagScreen.subjectKey: subjectOption.toJson(),
                  },
                );
              },
              tag: '${e.name.decode()}',
              count: e.count,
            ),
          ),
      ],
    );
  }
}
