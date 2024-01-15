import 'dart:async';
import 'package:alt_bangumi/helpers/common_helper.dart';
import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityBuilder extends ConsumerStatefulWidget {
  final Widget child;
  const ConnectivityBuilder({super.key, required this.child});

  @override
  ConsumerState<ConnectivityBuilder> createState() =>
      _ConnectivityHelperState();
}

class _ConnectivityHelperState extends ConsumerState<ConnectivityBuilder> {
  late final Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();

    _connectivity = Connectivity();
    // Subscribe to network connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        setState(() {
          _connectivityResult = result;
        });
        await _handleConnectivity();
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkConnectivity();
    });
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    _connectivityResult = await _connectivity.checkConnectivity();
    _handleConnectivity();
  }

  Future<void> _handleConnectivity() async {
    if (_connectivityResult == ConnectivityResult.none) {
      CommonHelper.showSnackBar(
          context: context, text: context.t.noInternetConnection);
    } else if (_connectivityResult == ConnectivityResult.wifi ||
        _connectivityResult == ConnectivityResult.mobile) {
      if (mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
