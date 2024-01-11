import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/screens/subject_characters_screen.dart';
import 'package:alt_bangumi/widgets/subject/relation_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../constants/enum_constant.dart';
import '../constants/text_constant.dart';
import '../models/relation_model/relation_model.dart';

class SubjectDetailCharacterWidget extends StatelessWidget {
  final SubjectModel? subject;
  final List<RelationModel>? characters;
  final ScreenSubjectOption? subjectOption;
  const SubjectDetailCharacterWidget({
    super.key,
    required this.subject,
    required this.characters,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (characters != null && characters!.isNotEmpty) ...[
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
                onPressed: () {
                  if (subject == null) return;
                  context.push(
                    SubjectCharactersScreen.route,
                    extra: {
                      SubjectCharactersScreen.relationsKey: characters,
                      SubjectCharactersScreen.subjectKey: subject,
                    },
                  );
                },
                child: Text(
                  '${TextConstant.more.getString(context)} >',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 100.w - 24.0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...characters!
                      .whereIndexed((index, element) => index < 10)
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
                      ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
