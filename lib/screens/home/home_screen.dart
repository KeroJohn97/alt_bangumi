import 'package:flutter/material.dart';
import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/screens/discover/discover_view.dart';
import 'package:alt_bangumi/widgets/scaffold_customed.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeIndexNotifier = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerStatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(homeIndexNotifier);
    return const ScaffoldCustomed(
      title: '',
      body: DiscoverView(),
      // IndexedStack(
      //   index: currentIndex,
      //   children: const [
      //     DiscoverView(),
      //     TimeCapsulesView(),
      //     FavouriteView(),
      //     SuperUnfoldedView(),
      //     TimeMachineView(),
      //   ],
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) =>
      //       ref.read(homeIndexNotifier.notifier).update((state) => value),
      //   currentIndex: currentIndex,
      //   items: [
      //     _getBottomNavigationBarItem(
      //       iconData: Icons.home_outlined,
      //       label: HomeIndexEnum.discover.display(context),
      //     ),
      //     _getBottomNavigationBarItem(
      //       iconData: Icons.access_time_outlined,
      //       label: HomeIndexEnum.timeCapsules.display(context),
      //     ),
      //     _getBottomNavigationBarItem(
      //       iconData: Icons.star_outline_outlined,
      //       label: HomeIndexEnum.favourite.display(context),
      //     ),
      //     _getBottomNavigationBarItem(
      //       iconData: Icons.chat_bubble_outline_outlined,
      //       label: HomeIndexEnum.superUnfolded.display(context),
      //     ),
      //     _getBottomNavigationBarItem(
      //       iconData: Icons.person_outlined,
      //       label: HomeIndexEnum.timeMachine.display(context),
      //     ),
      //   ],
      // ),
    );
  }

  BottomNavigationBarItem _getBottomNavigationBarItem({
    required IconData iconData,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: Colors.black),
      activeIcon: Icon(
        iconData,
        color: ColorConstant.themeColor,
      ),
      label: label,
    );
  }
}
