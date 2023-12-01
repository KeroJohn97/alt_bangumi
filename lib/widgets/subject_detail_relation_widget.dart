import 'package:alt_bangumi/widgets/subject/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../constants/enum_constant.dart';
import '../constants/text_constant.dart';
import '../models/relation_model/relation_model.dart';

class SubjectDetailRelationWidget extends StatelessWidget {
  final List<RelationModel>? relations;
  final SearchScreenSubjectOption? subjectOption;
  const SubjectDetailRelationWidget({
    super.key,
    required this.relations,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (relations != null) ...[
          const SizedBox(height: 8.0),
          Text(
            TextConstant.associate.getString(context),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...relations!
                    .map(
                      (e) => RelationCard(
                        relation: e,
                        height: 120.0,
                        width: 80.0,
                        group: SubjectRelationGroup.relation,
                        option: subjectOption,
                        sizeGroup: ImageSizeGroup.medium,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
