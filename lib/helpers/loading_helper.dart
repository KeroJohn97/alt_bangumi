import 'package:alt_bangumi/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';

class _LoadingController {
  final bool Function() close;
  final bool Function() isActive;

  _LoadingController({required this.close, required this.isActive});
}

class LoadingHelper {
  static final _instance = LoadingHelper._();
  LoadingHelper._();
  factory LoadingHelper.instance() => _instance;

  _LoadingController? _loadingController;

  bool isActive() => _loadingController?.isActive() ?? false;

  void hide() {
    _loadingController?.close();
    _loadingController = null;
  }

  void show({
    required BuildContext context,
  }) {
    if (_loadingController != null) return;
    _loadingController ??= _showOverlay(context: context);
  }

  _LoadingController _showOverlay({
    required BuildContext context,
  }) {
    final overlay = OverlayEntry(
      builder: (_) => const CustomLoadingWidget(),
    );

    Overlay.of(context).insert(overlay);

    return _LoadingController(
      close: () {
        overlay.remove();
        return true;
      },
      isActive: () => true,
    );
  }
}
