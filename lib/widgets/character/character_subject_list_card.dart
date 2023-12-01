import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/models/related_subject_model.dart';
import 'package:alt_bangumi/repositories/person_repository.dart';
import 'package:alt_bangumi/screens/person_detail_screen.dart';
import 'package:alt_bangumi/screens/subject_detail_screen.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/character_person_model.dart';

class SubjectListCard extends ConsumerStatefulWidget {
  final List<CharacterPersonModel>? characterPersons;
  final List<RelatedSubjectModel>? subjects;
  const SubjectListCard({
    super.key,
    required this.characterPersons,
    required this.subjects,
  });

  @override
  ConsumerState<SubjectListCard> createState() => _SubjectListCardState();
}

class _SubjectListCardState extends ConsumerState<SubjectListCard> {
  void _onPerson({
    required BuildContext context,
    required CharacterPersonModel characterPerson,
  }) async {
    final result = await PersonRepository.getPerson('${characterPerson.id}');
    if (!mounted) return;
    context.push(
      PersonDetailScreen.route,
      extra: {
        PersonDetailScreen.personKey: result,
      },
    );
  }

  void _onSubject({
    required BuildContext context,
    required RelatedSubjectModel relatedSubject,
  }) async {
    context.push(
      SubjectDetailScreen.route,
      extra: {
        SubjectDetailScreen.subjectIdKey: relatedSubject.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final characterPersons = widget.characterPersons;
    final characterSubjects = widget.subjects;
    if (characterSubjects?.isEmpty ?? true) return const Text('EMpty');
    return ListView.builder(
        shrinkWrap: true,
        itemCount: characterSubjects!.length,
        itemBuilder: (context, index) {
          final characterPerson = characterPersons?.firstWhereOrNull(
              (element) => element.subjectId == characterSubjects[index].id);
          return GestureDetector(
            onTap: () => _onSubject(
                context: context, relatedSubject: characterSubjects[index]),
            child: Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              height: 80.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomNetworkImageWidget(
                    height: 80.0,
                    width: 60.0,
                    radius: 8.0,
                    imageUrl: '${characterSubjects[index].image}',
                    boxFit: BoxFit.cover,
                    onTap: () => _onSubject(
                      context: context,
                      relatedSubject: characterSubjects[index],
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${characterSubjects[index].nameCn}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${characterSubjects[index].name}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            // fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (characterPerson != null)
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => _onPerson(
                                    context: context,
                                    characterPerson: characterPerson),
                                child: Row(
                                  children: [
                                    CustomNetworkImageWidget(
                                      height: 25.0,
                                      width: 25.0,
                                      radius: 4.0,
                                      imageUrl:
                                          '${characterPerson.images?.small}',
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text.rich(
                                      TextSpan(
                                        text: '${characterPerson.name} ',
                                        children: [
                                          TextSpan(
                                            text: characterPerson.type == 1
                                                ? 'CV'
                                                : '',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      border: Border.all(
                          width: 0.25, color: ColorConstant.themeColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '${characterSubjects[index].staff}',
                      style: const TextStyle(fontSize: 8.0),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            ),
          );
        });
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer();

  @override
  Widget build(BuildContext context) {
    return const CustomShimmerWidget(borderRadius: null);
  }
}
