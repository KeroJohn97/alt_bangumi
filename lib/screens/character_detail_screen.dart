import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/providers/character_detail_screen_provider.dart';
import 'package:alt_bangumi/widgets/character/character_subject_list_card.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character_model/character_model.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(characterDetailScreenProvider.notifier)
          .loadCharacter(widget.character);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustomed(
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
              ),
              PopupMenuItem(
                child: Text(
                  TextConstant.copyLink.getString(context),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  TextConstant.copyShare.getString(context),
                ),
              ),
            ];
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          children: [
            Text.rich(
              TextSpan(
                text: '${widget.character.name} ',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '${widget.character.name}',
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
                            Text('${key ?? infobox.key} : $value'),
                            const SizedBox(height: 4.0),
                          ],
                        );
                      }).toList()
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
              }).toList(),
            ],
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.translate_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            Text('${widget.character.summary}'),
            const SizedBox(height: 8.0),
            const Divider(),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  TextConstant.performance.getString(context),
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '${TextConstant.moreWorks.getString(context)} >',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const _CharacterSubjectListCard(),
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
    );
  }
}

class _CharacterSubjectListCard extends ConsumerWidget {
  const _CharacterSubjectListCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterDetailScreenProvider);
    switch (state.stateEnum) {
      case CharacterDetailScreenStateEnum.initial:
        // TODO: Handle this case.
        break;
      case CharacterDetailScreenStateEnum.loading:
        // TODO: Handle this case.
        break;
      case CharacterDetailScreenStateEnum.failure:
        // TODO: Handle this case.
        break;
      case CharacterDetailScreenStateEnum.success:
        return SubjectListCard(
          characterPersons: state.characterPersons,
          subjects: state.characterSubjects,
        );
    }
    return const Placeholder();
  }
}
