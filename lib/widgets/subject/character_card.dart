import 'package:alt_bangumi/models/relation_model/relation_model.dart';
import 'package:alt_bangumi/widgets/custom_network_image_widget.dart';
import 'package:flutter/material.dart';

class RelationCard extends StatelessWidget {
  final RelationModel relation;
  final double height;
  final double width;
  final VoidCallback? voidCallback;
  final BoxFit boxFit;
  final double scale;
  const RelationCard({
    super.key,
    required this.relation,
    required this.height,
    required this.width,
    this.voidCallback,
    this.boxFit = BoxFit.cover,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final title =
        '${(relation.nameCn?.isEmpty ?? true ? '${relation.name}' : relation.nameCn) ?? relation.name}';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => voidCallback?.call(),
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(right: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              surfaceTintColor: Colors.white,
              child: CustomNetworkImageWidget(
                height: height,
                width: width,
                radius: 8.0,
                imageUrl: relation.images?.large,
                alignment: Alignment.topCenter,
                enableTap: false,
                boxFit: boxFit,
                scale: scale,
              ),
            ),
            SizedBox(
              width: width,
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 10.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              '${relation.relation}',
              style: const TextStyle(
                fontSize: 10.0,
                color: Colors.grey,
                // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
