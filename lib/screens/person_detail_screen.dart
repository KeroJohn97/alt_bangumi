import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:alt_bangumi/providers/person_detail_screen_provider.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:alt_bangumi/widgets/custom_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/person_model/person_model.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(personDetailScreenProvider.notifier).loadPerson(widget.person);
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.translate_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...widget.person.infobox!.map((infobox) {
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
            Text('${widget.person.summary}'),
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
            const _PersonSubjectListCard(),
            // ListView.separated(itemBuilder: (context,index){
            //   return SizedBox();
            // }, separatorBuilder: (context,index) => SizedBox(height: 8.0), itemCount: person.stat)
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

class _PersonSubjectListCard extends ConsumerWidget {
  const _PersonSubjectListCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personDetailScreenProvider);
    switch (state.stateEnum) {
      case PersonDetailScreenStateEnum.initial:
        // TODO: Handle this case.
        break;
      case PersonDetailScreenStateEnum.loading:
        // TODO: Handle this case.
        break;
      case PersonDetailScreenStateEnum.failure:
        // TODO: Handle this case.
        break;
      case PersonDetailScreenStateEnum.success:
        return SubjectListCard(
          characterPersons: state.personCharacters?.sublist(
              0,
              (state.personCharacters?.length ?? 0) >= 3
                  ? 3
                  : state.personCharacters?.length),
          subjects: state.personSubjects?.sublist(
              0,
              (state.personSubjects?.length ?? 0) >= 3
                  ? 3
                  : state.personSubjects?.length),
        );
    }
    return const SizedBox(
      height: 50.0,
      child: CustomShimmerWidget(borderRadius: null),
    );
  }
}
