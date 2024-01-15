import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/loading_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:alt_bangumi/models/episode_model/datum_model.dart';
import 'package:alt_bangumi/models/episode_model/episode_model.dart';
import 'package:alt_bangumi/providers/subject_detail_screen_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubjectDetailEpisodeWidget extends ConsumerWidget {
  final AutoDisposeStateNotifierProvider<SubjectDetailScreenNotifier,
      SubjectDetailScreenState> provider;
  final EpisodeModel? episode;
  final PageController pageController;
  final int pageCount;
  final ValueNotifier pageIndex;
  final bool isMusic;
  const SubjectDetailEpisodeWidget({
    super.key,
    required this.provider,
    required this.episode,
    required this.pageController,
    required this.pageCount,
    required this.pageIndex,
    this.isMusic = false,
  });

  void _loadEpisodes({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    if (episode?.data == null) return;
    LoadingHelper.instance().show(context: context);
    await ref.read(provider.notifier).loadEpisodes();
    LoadingHelper.instance().hide();
    final state = ref.read(provider);
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
              itemCount: state.episode!.data!.length,
              itemBuilder: (context, index) {
                // final name = isMusic
                //     ? (state.episode?.data?[index].name)
                //     : state.episode?.data?[index].nameCn;
                // if (name?.isEmpty ?? true) {
                //   return const SizedBox.shrink();
                // }
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: _EpisodeRow(
                    e: state.episode!.data![index],
                    isMusic: isMusic,
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (episode?.total != null && episode!.total! > 0) ...[
          Row(
            children: [
              Text(
                isMusic ? context.t.trackList : context.t.chapter,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Spacer(),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.tv_outlined,
              //     color: Colors.grey,
              //   ),
              // ),
              IconButton(
                onPressed: () {
                  ref.read(provider.notifier).sortEpisodes();
                },
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      context.t.sort,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Icon(
                      Icons.sort_outlined,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () => _loadEpisodes(context: context, ref: ref),
                icon: Text(
                  '${t.more} >',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          if (episode?.data != null) ...[
            ...episode!.data!.whereIndexed((index, element) => index < 3).map(
                  (e) => _EpisodeRow(e: e, isMusic: isMusic),
                ),
            if (episode!.data!.length >= 4)
              _EpisodeRow(
                  e: episode!.data![3], color: Colors.grey, isMusic: isMusic)
          ],
        ],
      ],
    );
  }
}

class _EpisodeRow extends StatelessWidget {
  final DatumModel e;
  final Color color;
  final bool isMusic;
  const _EpisodeRow({
    required this.e,
    this.color = Colors.black,
    this.isMusic = false,
  });

  @override
  Widget build(BuildContext context) {
    final name = isMusic ? e.name : e.nameCn;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${e.ep}. ${name?.isEmpty ?? true ? context.t.upcoming : name.showHTML()}',
                  style: TextStyle(color: color),
                ),
                Text(
                  isMusic
                      ? '${t.disc}${e.disc}'
                      : '${t.premiere}: ${e.airdate} / ${t.duration}: ${e.duration}',
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
