import 'package:alt_bangumi/widgets/subject/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../constants/enum_constant.dart';
import '../constants/text_constant.dart';
import '../models/relation_model/relation_model.dart';

class SubjectDetailCharacterWidget extends StatelessWidget {
  final List<RelationModel>? characters;
  final ScreenSubjectOption? subjectOption;
  const SubjectDetailCharacterWidget({
    super.key,
    required this.characters,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (characters != null) ...[
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                TextConstant.role.getString(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  '${TextConstant.more.getString(context)} >',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...characters!
                    .map(
                      (e) => RelationCard(
                        relation: e,
                        height: 60.0,
                        width: 60.0,
                        scale: 1.5,
                        group: SubjectRelationGroup.character,
                        option: subjectOption,
                        sizeGroup: ImageSizeGroup.small,
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
