import 'dart:io';

import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/providers/person_detail_screen_provider.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../models/character_person_model.dart';
import '../models/person_model/person_model.dart';
import '../models/related_subject_model.dart';
import '../widgets/character/character_subject_list_card.dart';

class PersonDetailScreen extends ConsumerStatefulWidget {
  final PersonModel person;
  const PersonDetailScreen({
    super.key,
    required this.person,
  });

  static const route = '/person';
  static const personKey = 'person_key';

  @override
  ConsumerState<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends ConsumerState<PersonDetailScreen> {
  late final ScrollController _scrollController;
  late final AutoDisposeStateNotifierProvider<PersonDetailScreenNotifier,
      PersonDetailScreenState> personDetailScreenProvider;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    personDetailScreenProvider = AutoDisposeStateNotifierProvider<
        PersonDetailScreenNotifier, PersonDetailScreenState>((ref) {
      return PersonDetailScreenNotifier();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        ref.read(personDetailScreenProvider.notifier).loadPerson(widget.person);
      } catch (e) {
        CommonHelper.showToast(
          context.formatString(
            TextConstant.somethingDoesNotExist,
            [widget.person],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personDetailScreenProvider);
    return SelectionArea(
      selectionControls: Platform.isAndroid
          ? MaterialTextSelectionControls()
          : CupertinoTextSelectionControls(),
      child: ScaffoldCustomed(
        title: '',
        leading: const BackButton(color: Colors.black),
        trailing: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PopupMenuButton(
            child: const Icon(
              Icons.more_horiz_outlined,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    TextConstant.viewInBrowser.getString(context),
                  ),
                  onTap: () => CommonHelper.showInBrowser(
                    context: context,
                    url: '${HttpConstant.host}/person/${widget.person.id}',
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    TextConstant.copyLink.getString(context),
                  ),
                  onTap: () => Clipboard.setData(
                    ClipboardData(
                      text: '${HttpConstant.host}/person/${widget.person.id}',
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    TextConstant.copyShare.getString(context),
                  ),
                  onTap: () => Share.shareUri(
                    Uri.parse(
                      '${HttpConstant.host}/person/${widget.person.id}',
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: PrimaryScrollController(
            controller: _scrollController,
            child: ListView(
              cacheExtent: 200.h,
              children: [
                Text.rich(
                  TextSpan(
                    text: '${widget.person.name} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: '${widget.person.name}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                CustomNetworkImageWidget(
                  height: 500.0,
                  width: 500.0,
                  radius: 0,
                  imageUrl: widget.person.images?.large,
                ),
                if (widget.person.infobox != null) ...[
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => CommonHelper.translate(
                        context: context,
                        text: widget.person.infobox.toString(),
                        isRefresh: false,
                      ),
                      icon: const Icon(
                        Icons.translate_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ...widget.person.infobox!.map((infobox) {
                    var key = infobox.key;
                    var value = infobox.value;

                    if (value is List<dynamic>) {
                      if (value.isEmpty) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...value.map((e) {
                            key = e['k'];
                            value = e['v'];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${key ?? infobox.key} : $value'),
                                const SizedBox(height: 4.0),
                              ],
                            );
                          })
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$key : $value'),
                        const SizedBox(height: 4.0),
                      ],
                    );
                  }),
                ],
                if (widget.person.summary?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => CommonHelper.translate(
                        context: context,
                        text: widget.person.summary,
                        isRefresh: false,
                      ),
                      icon: const Icon(
                        Icons.translate_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text('${widget.person.summary}'),
                ],
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      TextConstant.recentlyParticipated.getString(context),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     '${TextConstant.moreWorks.getString(context)} >',
                    //     style: const TextStyle(color: Colors.grey),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 8.0),
                _PersonSubjectListCard(
                  personCharacters: state.personCharacters,
                  personSubjects: state.personSubjects,
                ),
                // ListView.separated(itemBuilder: (context,index){
                //   return SizedBox();
                // }, separatorBuilder: (context,index) => SizedBox(height: 8.0), itemCount: person.stat)
                // const SizedBox(height: 8.0),
                // const SizedBox(height: 8.0),
                // const SizedBox(height: 8.0),
                // const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PersonSubjectListCard extends ConsumerWidget {
  final List<CharacterPersonModel>? personCharacters;
  final List<RelatedSubjectModel>? personSubjects;
  const _PersonSubjectListCard({
    required this.personCharacters,
    required this.personSubjects,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubjectListCard(
      characterPersons: personCharacters,
      subjects: personSubjects,
    );
  }
}
