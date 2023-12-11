import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';

import '../constants/enum_constant.dart';
import '../repositories/bad_repository.dart';

class ScaffoldCustomed extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final bool? resizeToAvoidBottomInset;
  final String? title;
  final TextStyle? titleTextStyle;
  final Widget body;
  final BottomNavigationBar? bottomNavigationBar;
  final bool showAppBar;
  final bool showDrawer;
  final Color? backgroundColor;
  final double? titleSpacing;
  final Widget? titleWidget;
  const ScaffoldCustomed({
    super.key,
    this.leading,
    this.trailing,
    this.resizeToAvoidBottomInset,
    this.title,
    this.titleTextStyle,
    required this.body,
    this.bottomNavigationBar,
    this.showAppBar = true,
    this.showDrawer = false,
    this.backgroundColor,
    this.titleSpacing,
    this.titleWidget,
  });

  @override
  State<ScaffoldCustomed> createState() => _ScaffoldCustomedState();
}

class _ScaffoldCustomedState extends State<ScaffoldCustomed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.showAppBar
          ? AppBarCustomed(
              title: widget.title,
              leading: widget.leading,
              trailing: widget.trailing,
              textStyle: widget.titleTextStyle,
              showDrawer: widget.showDrawer,
              backgroundColor: widget.backgroundColor ?? Colors.transparent,
              titleSpacing: widget.titleSpacing,
              titleWidget: widget.titleWidget,
            )
          : null,
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
      backgroundColor: widget.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await BadRepository.fetchList(
              subjectOption: ScreenSubjectOption.anime, page: 1);
          log('message result: $result');
        },
      ),
    );
  }
}

class AppBarCustomed extends StatelessWidget implements PreferredSizeWidget {
  final bool showDrawer;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? textStyle;
  final double? titleSpacing;
  final Color backgroundColor;
  final String? title;
  final Widget? titleWidget;

  const AppBarCustomed({
    super.key,
    required this.showDrawer,
    this.leading,
    this.trailing,
    this.textStyle,
    this.titleSpacing,
    this.backgroundColor = Colors.transparent,
    this.title,
    this.titleWidget,
  }) : assert(title != null || titleWidget != null);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: leading,
      automaticallyImplyLeading: true,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleSpacing: titleSpacing,
      title: titleWidget ??
          SizedBox(
            width: CommonHelper.screenWidth(context, value: 90),
            child: AutoSizeText(
              title ?? '',
              textAlign: TextAlign.center,
              style: textStyle ??
                  const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
              minFontSize: 13.0,
              maxLines: 1,
              stepGranularity: 0.1,
            ),
          ),
      centerTitle: true,
      actions: [
        trailing ?? const SizedBox.shrink(),
        (showDrawer)
            ? Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  splashRadius: 24.0,
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              })
            : const SizedBox.shrink()
        // TODO remove comment below
        // const Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 12.0),
        //     child: SizedBox(height: 24.0, width: 24.0),
        //   )
        ,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
