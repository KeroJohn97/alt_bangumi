import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/screens/subject_persons_screen.dart';
import 'package:alt_bangumi/widgets/subject/relation_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../constants/enum_constant.dart';
import '../models/relation_model/relation_model.dart';

class SubjectDetailPersonWidget extends StatelessWidget {
  final SubjectModel? subject;
  final List<RelationModel>? persons;
  final ScreenSubjectOption? subjectOption;
  const SubjectDetailPersonWidget({
    super.key,
    required this.subject,
    required this.persons,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (persons != null && persons!.isNotEmpty) ...[
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                context.t.productionStaff,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.push(
                    SubjectPersonsScreen.route,
                    extra: {
                      SubjectPersonsScreen.relationsKey: persons,
                      SubjectPersonsScreen.subjectKey: subject,
                    },
                  );
                },
                child: Text(
                  '${t.more} >',
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
              child: Builder(builder: (context) {
                final set = <String>{};
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...persons!
                        .where((element) => set.add('${element.id}'))
                        .toList()
                        .whereIndexed((index, element) => index < 10)
                        .map(
                          (e) => RelationCard(
                            relation: e,
                            height: 60,
                            width: 60,
                            group: SubjectRelationGroup.productionStaff,
                            option: subjectOption,
                            sizeGroup: ImageSizeGroup.small,
                          ),
                        ),
                  ],
                );
              }),
            ),
          ),
        ],
      ],
    );
  }
}
