import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/models/subject_model/tag_model.dart';
import 'package:alt_bangumi/screens/tag/single_tag_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTagGrid extends StatelessWidget {
  final List<TagModel>? tags;
  final ScrollController scrollController;
  final ScreenSubjectOption subjectOption;
  const CustomTagGrid({
    super.key,
    required this.tags,
    required this.scrollController,
    required this.subjectOption,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      children: [
        if (tags != null)
          ...tags!.map(
            (e) {
              double? value = double.tryParse('${e.count}');
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  context.push(
                    SingleTagScreen.route,
                    extra: {
                      SingleTagScreen.subjectKey: subjectOption.toJson(),
                      SingleTagScreen.tagKey: e.name,
                    },
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${e.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        '${value != null ? value.showInUnit() : e.count}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
