import 'package:alt_bangumi/models/episode_model/episode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../constants/color_constant.dart';
import '../constants/text_constant.dart';

class SubjectDetailEpisodeWidget extends StatelessWidget {
  final EpisodeModel? episode;
  final PageController pageController;
  final int pageCount;
  final ValueNotifier pageIndex;
  const SubjectDetailEpisodeWidget({
    super.key,
    required this.episode,
    required this.pageController,
    required this.pageCount,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (episode?.total != null && episode!.total! > 0) ...[
          Row(
            children: [
              Text(
                TextConstant.chapter.getString(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.tv_outlined,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.list_outlined,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.sort_outlined,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            transform: Matrix4.translationValues(-12.0, 0, 0.0),
            height: 220.0,
            child: PageView.builder(
              controller: pageController,
              itemCount: pageCount,
              itemBuilder: (context, pageIndex) {
                int itemCount;
                if (pageCount == 1) {
                  itemCount = episode!.total!;
                } else if (pageCount == pageIndex + 1) {
                  itemCount = episode!.total! % (32 * pageIndex);
                } else {
                  itemCount = 32;
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 12.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, gridIndex) {
                    final index = (pageIndex * 32) + gridIndex;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            width: 20.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${episode?.data?[index].ep}',
                              // '${(pageIndex * 32) + (gridIndex + 1)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 4.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: ColorConstant.starColor,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder(
              valueListenable: pageIndex,
              builder: (context, value, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pageCount, (int index) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: pageIndex.value == index
                              ? Colors.black
                              : Colors.white,
                          border: Border.all(),
                        ),
                      );
                    }),
                  ),
                );
              }),
        ],
      ],
    );
  }
}
