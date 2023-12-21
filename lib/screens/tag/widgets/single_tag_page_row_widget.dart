import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/providers/single_tag_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleTagPageRowWidget extends ConsumerWidget {
  final VoidCallback previousCallback;
  final VoidCallback nextCallback;
  const SingleTagPageRowWidget({
    super.key,
    required this.previousCallback,
    required this.nextCallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(singleTagScreenProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
      child: SizedBox(
        height: 40.0,
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: state.page <= 1 ? null : previousCallback,
              icon: const Icon(Icons.chevron_left),
            ),
            Text(
              '${state.page}',
              style: const TextStyle(fontSize: 16.0),
            ),
            IconButton(
              onPressed: state.results!.length % 24 != 0 ? null : nextCallback,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
