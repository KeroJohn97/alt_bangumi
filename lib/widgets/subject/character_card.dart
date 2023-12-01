import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:alt_bangumi/repositories/character_repository.dart';
import 'package:alt_bangumi/repositories/person_repository.dart';
import 'package:alt_bangumi/screens/character_detail_screen.dart';
import 'package:alt_bangumi/screens/person_detail_screen.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RelationCard extends StatefulWidget {
  final RelationModel relation;
  final double height;
  final double width;
  final SubjectRelationGroup group;
  final SearchScreenSubjectOption? option;
  final ImageSizeGroup sizeGroup;
  final BoxFit boxFit;
  final double scale;
  const RelationCard({
    super.key,
    required this.relation,
    required this.height,
    required this.width,
    required this.group,
    required this.option,
    required this.sizeGroup,
    this.boxFit = BoxFit.cover,
    this.scale = 1.0,
  });

  @override
  State<RelationCard> createState() => _RelationCardState();
}

class _RelationCardState extends State<RelationCard> {
  _getSubtitleCharater() {
    switch (widget.option) {
      case SearchScreenSubjectOption.entry:
        // TODO: Handle this case.
        break;
      case SearchScreenSubjectOption.anime:
        return '${widget.relation.actors?.isEmpty ?? true ? '${widget.relation.relation}' : widget.relation.actors!.first.name}';
      case SearchScreenSubjectOption.book:
        // TODO: Handle this case.
        break;
      case SearchScreenSubjectOption.music:
        // TODO: Handle this case.
        break;
      case SearchScreenSubjectOption.game:
        // TODO: Handle this case.
        break;
      case SearchScreenSubjectOption.real:
        // TODO: Handle this case.
        break;
      case SearchScreenSubjectOption.character:
        // TODO: Handle this case.
        break;
      case SearchScreenSubjectOption.user:
        // TODO: Handle this case.
        break;
      case null:
        break;
    }
    return '${widget.relation.relation}';
  }

  _getSubtitle() {
    switch (widget.group) {
      case SubjectRelationGroup.character:
        return _getSubtitleCharater();
      case SubjectRelationGroup.productionStaff:
        return '${widget.relation.career?.map((e) => _matchCareer(e)).toList()}';
      case SubjectRelationGroup.relation:
        return '${widget.relation.relation}';
    }
  }

  String? _matchCareer(String career) {
    final matched = CareerGroup.values
        .firstWhereOrNull((element) => element.name == career.toLowerCase());
    if (matched == null) return null;
    return matched.displayName(context);
  }

  _getImageUrl() {
    switch (widget.sizeGroup) {
      case ImageSizeGroup.small:
        return widget.relation.images?.small;
      case ImageSizeGroup.common:
        return widget.relation.images?.common;
      case ImageSizeGroup.medium:
        return widget.relation.images?.medium;
      case ImageSizeGroup.large:
        return widget.relation.images?.large;
      case ImageSizeGroup.grid:
        return widget.relation.images?.grid;
    }
  }

  _onTap(BuildContext context) async {
    switch (widget.group) {
      case SubjectRelationGroup.character:
        final character =
            await CharacterRepository.getCharacter('${widget.relation.id}');
        if (!mounted) return;
        context.push(
          CharacterDetailScreen.route,
          extra: {
            CharacterDetailScreen.characterKey: character,
          },
        );
        break;
      case SubjectRelationGroup.productionStaff:
        final person =
            await PersonRepository.getPerson('${widget.relation.id}');
        if (!mounted) return;
        context.push(
          PersonDetailScreen.route,
          extra: {
            PersonDetailScreen.personKey: person,
          },
        );
        break;
      case SubjectRelationGroup.relation:
        // TODO Handle this case
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final title =
        '${(widget.relation.nameCn?.isEmpty ?? true ? '${widget.relation.name}' : widget.relation.nameCn) ?? widget.relation.name}';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onTap(context),
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(right: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              surfaceTintColor: Colors.white,
              child: CustomNetworkImageWidget(
                height: widget.height,
                width: widget.width,
                radius: 8.0,
                imageUrl: _getImageUrl(),
                alignment: Alignment.topCenter,
                boxFit: widget.boxFit,
                scale: widget.scale,
                onTap: () => _onTap(context),
              ),
            ),
            SizedBox(
              width: widget.width,
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 10.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: widget.width,
              child: Text(
                '${_getSubtitle()}',
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
