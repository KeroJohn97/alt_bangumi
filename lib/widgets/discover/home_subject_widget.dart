import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/widgets/discover/search/anime_loading_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/discover_view_provider.dart';
import 'channel_anime_card.dart';

class HomeSubjectWidget extends StatelessWidget {
  final AutoSizeGroup mainAutoSizeGroup;
  final AutoSizeGroup subAutoSizeGroup;
  final ScreenSubjectOption subjectOption;
  const HomeSubjectWidget({
    super.key,
    required this.mainAutoSizeGroup,
    required this.subAutoSizeGroup,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              subjectOption.getString(context),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const Spacer(),
            // TextButton(
            //   onPressed: _pushChannelScreen,
            //   child: Text('${t.channel.getString(context)} >'),
            // ),
          ],
        ),
        const SizedBox(height: 10.0),
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(discoverViewProvider);
            switch (state.stateEnum) {
              case DiscoverViewStateEnum.initial:
                return const AnimeLoadingComponent();
              case DiscoverViewStateEnum.loading:
                return const AnimeLoadingComponent();
              case DiscoverViewStateEnum.failure:
                return const Text('Failed');
              case DiscoverViewStateEnum.success:
                // final channel = state.channel;
                List<SubjectModel>? rankedSubject;
                switch (subjectOption) {
                  case ScreenSubjectOption.anime:
                    rankedSubject = state.rankedAnime;
                    break;
                  case ScreenSubjectOption.book:
                    rankedSubject = state.rankedBook;
                    break;
                  case ScreenSubjectOption.music:
                    rankedSubject = state.rankedMusic;
                    break;
                  case ScreenSubjectOption.game:
                    rankedSubject = state.rankedGame;
                    break;
                  case ScreenSubjectOption.film:
                    rankedSubject = state.rankedFilm;
                    break;
                  default:
                    break;
                }
                // especially in presenting other loaded and ranked subjects
                if (rankedSubject == null) {
                  return const AnimeLoadingComponent();
                }
                return Column(
                  children: [
                    if (rankedSubject.isNotEmpty)
                      Builder(builder: (context) {
                        return ChannelAnimeCard(
                          imageUrl: '${rankedSubject?.first.images?.large}',
                          followers:
                              rankedSubject?.first.follow?.decode() ?? '',
                          title: rankedSubject?.first.name.decode() ?? '',
                          id: rankedSubject?.first.id,
                          height: 500.0,
                          width: 100.w,
                          autoSizeGroup: mainAutoSizeGroup,
                        );
                      }),
                    const SizedBox(height: 12.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...rankedSubject
                              .sublist(rankedSubject.isEmpty ? 0 : 1)
                              .asMap()
                              .entries
                              .map(
                            (entry) {
                              final index =
                                  entry.key; // get the index of the element
                              final e = entry.value; // get the element

                              return Row(
                                children: [
                                  ChannelAnimeCard(
                                    imageUrl: '${e.images?.small}',
                                    followers: e.follow?.decode() ?? '',
                                    title: e.name.decode() ?? '',
                                    id: e.id,
                                    height: 150.0,
                                    width: 30.w,
                                    autoSizeGroup: subAutoSizeGroup,
                                    maxFontSize: 16.0,
                                  ),
                                  if (index < (rankedSubject?.length ?? 1) - 2)
                                    const SizedBox(width: 12.0),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                );
            }
          },
        ),
      ],
    );
  }
}
