import 'dart:async';

import 'package:flutter/material.dart';

final globalDebouncerHelper = DebouncerHelper();

class DebouncerHelper {
  final int milliseconds;
  Timer? _timer;

  DebouncerHelper({
    this.milliseconds = 1000,
  });

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
