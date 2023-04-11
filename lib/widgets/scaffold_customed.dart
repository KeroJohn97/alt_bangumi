import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bangumi/helpers/common_helper.dart';

class ScaffoldCustomed extends StatefulWidget {
  final Widget? leading;
  final bool? resizeToAvoidBottomInset;
  final String? title;
  final TextStyle? titleTextStyle;
  final Widget body;
  final BottomNavigationBar? bottomNavigationBar;
  const ScaffoldCustomed({
    super.key,
    this.leading,
    this.resizeToAvoidBottomInset,
    this.title,
    this.titleTextStyle,
    required this.body,
    this.bottomNavigationBar,
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
      appBar: AppBarCustomed(
        title: widget.title,
        leading: widget.leading,
        textStyle: widget.titleTextStyle,
      ),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}

class AppBarCustomed extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final TextStyle? textStyle;

  const AppBarCustomed({
    super.key,
    required this.title,
    this.leading,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: leading,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: SizedBox(
        width: CommonHelper.screenWidth(context, value: 90),
        child: AutoSizeText(
          title ?? '',
          textAlign: TextAlign.center,
          style: textStyle ??
              const TextStyle(
                fontSize: 20.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
          minFontSize: 13.0,
          maxLines: 1,
          stepGranularity: 0.1,
        ),
      ),
      centerTitle: true,
      actions: [
        Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(Icons.menu),
            splashRadius: 24.0,
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
