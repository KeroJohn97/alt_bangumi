import 'package:alt_bangumi/screens/calendar/widgets/calendar_loading_widget.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/helpers/extension_helper.dart';
import 'package:alt_bangumi/repositories/global_repository.dart';
import 'package:alt_bangumi/screens/calendar/widgets/calendar_grid_widget.dart';
import 'package:alt_bangumi/screens/calendar/widgets/calendar_list_widget.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:alt_bangumi/widgets/custom_switch_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _calendarScreenViweOptionNotifier =
    StateProvider((ref) => ScreenLayoutOption.values.first);

class CalendarScreen extends ConsumerStatefulWidget {
  static const route = '/calendar';
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _gridScrollController;
  late ScrollController _listScrollController;

  @override
  void initState() {
    super.initState();
    _gridScrollController = ScrollController();
    _listScrollController = ScrollController();
    _animationController = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 50),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _gridScrollController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  final _textStyle = const TextStyle(fontSize: 14.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    final viewOption = ref.watch(_calendarScreenViweOptionNotifier);
    final filterOption = ValueNotifier(CalendarScreenFilterOption.values.first);

    return ScaffoldCustomed(
      showDrawer: false,
      leading: const BackButton(color: Colors.black),
      trailing: Row(
        children: [
          ValueListenableBuilder(
              valueListenable: filterOption,
              builder: (context, value, child) {
                return CustomSwitchWidget(
                  activeIndex: value.index,
                  indexList: CalendarScreenFilterOption.values
                      .map((e) => e.index)
                      .toList(),
                  labelList: CalendarScreenFilterOption.values
                      .map((e) => e.getString(context).capitalizeFirst())
                      .toList(),
                  onChanged: (value) {
                    filterOption.value =
                        CalendarScreenFilterOption.values[value];
                  },
                  textStyle: _textStyle,
                );
              }),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: () {
              _animationController.reverse().then(
                (_) {
                  ref.read(_calendarScreenViweOptionNotifier.notifier).update(
                      (state) => ScreenLayoutOption.values[
                          (viewOption.index + 1) %
                              ScreenLayoutOption.values.length]);
                  _animationController.forward();
                },
              );
            },
            icon: _GetIcon(viewOption: viewOption),
            splashRadius: 24.0,
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ],
      ),
      title: '每日放送',
      body: FutureBuilder(
          future: GlobalRepository.getCalendar(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final calendar = snapshot.data!;
              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => FadeScaleTransition(
                  animation: _animationController,
                  child: child,
                ),
                child: Builder(
                  builder: (context) {
                    switch (viewOption) {
                      case ScreenLayoutOption.grid:
                        return CalendarGridWidget(
                          scrollController: _gridScrollController,
                          calendarList: calendar,
                        );
                      case ScreenLayoutOption.list:
                        return CalendarListWidget(
                          scrollController: _listScrollController,
                          calendarList: calendar,
                        );
                    }
                  },
                ),
              );
            }
            return const CalendarLoadingWidget();
          }),
    );
  }
}

class _GetIcon extends StatelessWidget {
  final ScreenLayoutOption viewOption;
  const _GetIcon({required this.viewOption});

  @override
  Widget build(BuildContext context) {
    switch (viewOption) {
      case ScreenLayoutOption.grid:
        return const Icon(
          Icons.grid_view,
          color: Colors.black,
        );
      case ScreenLayoutOption.list:
        return const Icon(
          Icons.list,
          color: Colors.black,
        );
    }
  }
}
