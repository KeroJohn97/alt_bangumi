import 'package:flutter/material.dart';

import '../models/subject_model/tag_model.dart';
import 'custom_tag_widget.dart';

class SubjectDetailTagWidget extends StatelessWidget {
  final List<TagModel>? tags;
  const SubjectDetailTagWidget({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if (tags == null) const SizedBox(height: 8.0),
        if (tags != null)
          ...tags!
              .map(
                (e) => CustomTagWidget(
                  onPressed: () {
                    // TODO tag search
                  },
                  tag: '${e.name}',
                  count: e.count,
                ),
              )
              .toList(),
      ],
    );
  }
}
