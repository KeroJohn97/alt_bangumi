// ignore_for_file: use_build_context_synchronously

import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/screens/person_detail_screen.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/color_constant.dart';
import '../constants/enum_constant.dart';
import '../constants/http_constant.dart';
import '../helpers/common_helper.dart';
import '../helpers/loading_helper.dart';
import '../repositories/person_repository.dart';

class SubjectPersonsScreen extends ConsumerWidget {
  final SubjectModel subject;
  final List<RelationModel> relations;
  const SubjectPersonsScreen({
    super.key,
    required this.relations,
    required this.subject,
  });

  static const route = '/subject/persons';
  static const relationsKey = 'relations_key';
  static const subjectKey = 'subject_key';

  void navigateToProductionStaff({
    required BuildContext context,
    required RelationModel relation,
  }) async {
    LoadingHelper.instance().show(context: context);
    final person = await PersonRepository.getPerson('${relation.id}');
    LoadingHelper.instance().hide();
    context.push(
      PersonDetailScreen.route,
      extra: {
        PersonDetailScreen.personKey: person,
      },
    );
  }

  String? _matchCareer({
    required BuildContext context,
    required String career,
  }) {
    final matched = CareerGroup.values
        .whereNot((element) => element == CareerGroup.producer)
        .firstWhereOrNull((element) => element.name == career.toLowerCase());
    if (matched == null) return null;
    return matched.getString(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name =
        subject.nameCn?.isEmpty ?? true ? subject.name : subject.nameCn;
    return ScaffoldCustomed(
      title: context.t.productionStaffsBelong(subject: name ?? ''),
      leading: const BackButton(color: Colors.black),
      trailing: PopupMenuButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(
            Icons.more_horiz_outlined,
            color: Colors.black,
          ),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text(
                context.t.viewInBrowser,
              ),
              onTap: () {
                final url =
                    '${HttpConstant.host}/subject/${subject.id}/persons';
                CommonHelper.showInBrowser(context: context, url: url);
              },
            ),
          ];
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () => navigateToProductionStaff(
                      context: context, relation: relations[index]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          surfaceTintColor: Colors.white,
                          child: CustomNetworkImageWidget(
                            height: 60.0,
                            width: 60.0,
                            radius: 8.0,
                            imageUrl: '${relations[index].images?.small}',
                            alignment: Alignment.topCenter,
                            boxFit: BoxFit.cover,
                            onTap: () => navigateToProductionStaff(
                                context: context, relation: relations[index]),
                            heroTag:
                                '${relations[index].images?.small}_characters_$index',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  relations[index].name.decode() ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          SizedBox(
                            width: 100.w - 60.0 - 24.0 - 12.0,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: ColorConstant.themeColor
                                          .withOpacity(0.5),
                                    ),
                                    child: Text(
                                      relations[index].relation.decode() ?? '',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  if (relations[index].career != null)
                                    ...relations[index].career!.map((e) {
                                      final matched = _matchCareer(
                                          context: context, career: e);
                                      if (matched == null) {
                                        return const SizedBox.shrink();
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: ColorConstant.themeColor
                                                .withOpacity(0.5),
                                          ),
                                          child: Text(
                                            matched,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                        ],
                      ),
                    ],
                  ),
                );
              },
              childCount: relations.length,
            ),
          ),
        ],
      ),
    );
  }
}
