import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/widgets/subject/relation_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../constants/enum_constant.dart';
import '../models/relation_model/relation_model.dart';

class SubjectDetailRelationWidget extends StatelessWidget {
  final List<RelationModel>? relations;
  final ScreenSubjectOption? subjectOption;
  const SubjectDetailRelationWidget({
    super.key,
    required this.relations,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (relations != null && relations!.isNotEmpty) ...[
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                context.t.associate,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.85,
                          child: Column(
                            children: [
                              const SizedBox(height: kToolbarHeight),
                              Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.6,
                                    ),
                                    itemCount: relations!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: RelationCard(
                                          relation: relations![index],
                                          height: 120.0,
                                          width: 80.0,
                                          group: SubjectRelationGroup.relation,
                                          option: subjectOption,
                                          sizeGroup: ImageSizeGroup.medium,
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: Text(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...relations!
                      .whereIndexed((index, element) => index < 10)
                      .map(
                        (e) => RelationCard(
                          relation: e,
                          height: 120.0,
                          width: 80.0,
                          group: SubjectRelationGroup.relation,
                          option: subjectOption,
                          sizeGroup: ImageSizeGroup.medium,
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
