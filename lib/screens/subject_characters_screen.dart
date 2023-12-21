// ignore_for_file: use_build_context_synchronously

import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/loading_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/relation_model/actor_model.dart';
import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/screens/person_detail_screen.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/http_constant.dart';
import '../repositories/character_repository.dart';
import '../repositories/person_repository.dart';
import 'character_detail_screen.dart';

class SubjectCharactersScreen extends ConsumerWidget {
  final SubjectModel subject;
  final List<RelationModel> relations;
  const SubjectCharactersScreen({
    super.key,
    required this.relations,
    required this.subject,
  });

  static const route = '/subject/characters';
  static const relationsKey = 'relations_key';
  static const subjectKey = 'subject_key';

  void navigateToCharacter({
    required BuildContext context,
    required RelationModel relation,
  }) async {
    LoadingHelper.instance().show(context: context);
    final character = await CharacterRepository.getCharacter('${relation.id}');
    LoadingHelper.instance().hide();
    context.push(
      CharacterDetailScreen.route,
      extra: {
        CharacterDetailScreen.characterKey: character,
      },
    );
  }

  void navigateToProductionStaff({
    required BuildContext context,
    required ActorModel actor,
  }) async {
    LoadingHelper.instance().show(context: context);
    final person = await PersonRepository.getPerson('${actor.id}');
    LoadingHelper.instance().hide();
    context.push(
      PersonDetailScreen.route,
      extra: {
        PersonDetailScreen.personKey: person,
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name =
        subject.nameCn?.isEmpty ?? true ? subject.name : subject.nameCn;

    return ScaffoldCustomed(
      title: context.formatString(
        TextConstant.charactersBelong.getString(context),
        [name],
      ),
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
                TextConstant.viewInBrowser.getString(context),
              ),
              onTap: () {
                final url =
                    '${HttpConstant.host}/subject/${subject.id}/characters';
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
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
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
                          scale: 1.5,
                          onTap: () => navigateToCharacter(
                              context: context, relation: relations[index]),
                          heroTag:
                              '${relations[index].images?.small}_characters_$index',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => navigateToCharacter(
                              context: context, relation: relations[index]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${relations[index].name}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color:
                                      ColorConstant.themeColor.withOpacity(0.5),
                                ),
                                child: Text(
                                  '${relations[index].relation}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100.w - 60 - 24 - 12,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                if (relations[index].actors != null)
                                  ...relations[index].actors!.map((e) {
                                    return GestureDetector(
                                      onTap: () => navigateToProductionStaff(
                                        context: context,
                                        actor: e,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: Row(
                                          children: [
                                            CustomNetworkImageWidget(
                                              height: 30.0,
                                              width: 30.0,
                                              radius: 8.0,
                                              imageUrl: '${e.images?.small}',
                                              alignment: Alignment.topCenter,
                                              scale: 1.4,
                                              heroTag:
                                                  '${e.images?.small}_persons_$index',
                                              onTap: () =>
                                                  navigateToProductionStaff(
                                                      context: context,
                                                      actor: e),
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              '${e.name}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4.0),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              childCount: relations.length,
            ),
          ),
        ],
      ),
    );
  }
}
