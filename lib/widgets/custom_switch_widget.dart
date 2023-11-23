import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {
  final int activeIndex;
  final ValueChanged<int>? onChanged;
  final List<int> indexList;
  final List<String> labelList;
  final TextStyle textStyle;

  const CustomSwitchWidget({
    super.key,
    required this.activeIndex,
    required this.onChanged,
    required this.indexList,
    required this.labelList,
    required this.textStyle,
  });

  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget>
    with TickerProviderStateMixin {
  void _onTap(int activeIndex) {
    if (widget.onChanged == null) return;
    widget.onChanged!(activeIndex);
  }

  AlignmentGeometry _getAlignment(int currentIndex) {
    if (currentIndex == 0) return Alignment.centerLeft;
    if (currentIndex == widget.indexList.last) {
      return Alignment.centerRight;
    }
    final value = (currentIndex * 2 - widget.indexList.length + 1) /
        widget.indexList.length;
    return Alignment(value, 0.0);
  }

  BorderRadius _getBorderRadius(int currentIndex) {
    if (currentIndex == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
      );
    }
    if (currentIndex == widget.indexList.last) {
      return const BorderRadius.only(
        topRight: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      );
    }
    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.indexList.map((index) {
          return Align(
            alignment: _getAlignment(index),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: index == widget.activeIndex
                      ? Colors.black12
                      : Colors.white,
                  borderRadius: _getBorderRadius(index),
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(
                  widget.labelList[index],
                  maxLines: 1,
                  style: widget.textStyle.copyWith(
                    color: index == widget.activeIndex
                        ? Colors.white
                        : Colors.black,
                    fontWeight: index == widget.activeIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
