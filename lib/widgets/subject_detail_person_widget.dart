import 'package:alt_bangumi/widgets/subject/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../constants/enum_constant.dart';
import '../constants/text_constant.dart';
import '../models/relation_model/relation_model.dart';

class SubjectDetailPersonWidget extends StatelessWidget {
  final List<RelationModel>? persons;
  final SearchScreenSubjectOption? subjectOption;
  const SubjectDetailPersonWidget({
    super.key,
    required this.persons,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (persons != null) ...[
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                TextConstant.productionStaff.getString(context),
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
            child: Builder(builder: (context) {
              final set = <String>{};
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...persons!
                      .where((element) => set.add('${element.id}'))
                      .toList()
                      .map(
                        (e) => RelationCard(
                          relation: e,
                          height: 60,
                          width: 60,
                          group: SubjectRelationGroup.productionStaff,
                          option: subjectOption,
                          sizeGroup: ImageSizeGroup.small,
                        ),
                      )
                      .toList(),
                ],
              );
            }),
          ),
        ],
      ],
    );
  }
}
