import 'dart:io';

import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/providers/character_detail_screen_provider.dart';
import 'package:alt_bangumi/widgets/character/character_subject_list_card.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/http_constant.dart';
import '../helpers/common_helper.dart';
import '../models/character_model/character_model.dart';
import '../models/character_person_model.dart';
import '../models/related_subject_model.dart';

class CharacterDetailScreen extends ConsumerStatefulWidget {
  final CharacterModel character;
  const CharacterDetailScreen({
    super.key,
    required this.character,
  });

  static const route = '/character';
  static const characterKey = 'character_key';

  @override
  ConsumerState<CharacterDetailScreen> createState() =>
      _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends ConsumerState<CharacterDetailScreen> {
  late final AutoDisposeStateNotifierProvider<CharacterDetailScreenNotifier,
      CharacterDetailScreenState> characterDetailScreenProvider;

  @override
  void initState() {
    super.initState();
    characterDetailScreenProvider = AutoDisposeStateNotifierProvider<
        CharacterDetailScreenNotifier, CharacterDetailScreenState>((ref) {
      return CharacterDetailScreenNotifier();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await ref
            .read(characterDetailScreenProvider.notifier)
            .loadCharacter(widget.character);
      } catch (e) {
        CommonHelper.showToast(
          // ignore: use_build_context_synchronously
          context.t.somethingDoesNotExist(something: widget.character),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterDetailScreenProvider);
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
                    context.t.viewInBrowser,
                  ),
                  onTap: () => CommonHelper.showInBrowser(
                    context: context,
                    url:
                        '${HttpConstant.host}/character/${widget.character.id}',
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    context.t.copyLink,
                  ),
                  onTap: () => Clipboard.setData(
                    ClipboardData(
                      text:
                          '${HttpConstant.host}/character/${widget.character.id}',
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    context.t.copyShare,
                  ),
                  onTap: () => Share.shareUri(
                    Uri.parse(
                      '${HttpConstant.host}/character/${widget.character.id}',
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            cacheExtent: 200.h,
            children: [
              Text.rich(
                TextSpan(
                  text: '${widget.character.name.decode()} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '${widget.character.name.decode()}',
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
                imageUrl: widget.character.images?.large,
              ),
              if (widget.character.infobox != null) ...[
                const SizedBox(height: 8.0),
                ...widget.character.infobox!.map((infobox) {
                  var key = infobox.key;
                  var value = infobox.value;

                  if (value is List<dynamic> && value.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...value.map((e) {
                          key = e['k'];
                          value = e['v'];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${key.decode() ?? infobox.key?.decode() ?? ''} : ${value.toString().decode() ?? ''}'),
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
                      Text(
                          '${key.decode() ?? ''} : ${value.toString().decode() ?? ''}'),
                      const SizedBox(height: 4.0),
                    ],
                  );
                }),
              ],
              if (widget.character.summary?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => CommonHelper.translate(
                      context: context,
                      text: widget.character.summary,
                      isRefresh: false,
                    ),
                    icon: const Icon(
                      Icons.translate_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text('${widget.character.summary.decode()}'),
              ],
              const SizedBox(height: 8.0),
              const Divider(),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    context.t.performance,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     '${t.moreWorks} >',
                  //     style: const TextStyle(color: Colors.grey),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 8.0),
              _CharacterSubjectListCard(
                characterPersons: state.characterPersons,
                characterSubjects: state.characterSubjects,
              ),
              // ListView.separated(itemBuilder: (context,index){
              //   return SizedBox();
              // }, separatorBuilder: (context,index) => SizedBox(height: 8.0), itemCount: character.stat)
              const SizedBox(height: 8.0),
              const SizedBox(height: 8.0),
              const SizedBox(height: 8.0),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterSubjectListCard extends ConsumerWidget {
  final List<CharacterPersonModel>? characterPersons;
  final List<RelatedSubjectModel>? characterSubjects;
  const _CharacterSubjectListCard({
    required this.characterPersons,
    required this.characterSubjects,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubjectListCard(
      characterPersons: characterPersons,
      subjects: characterSubjects,
    );
  }
}
