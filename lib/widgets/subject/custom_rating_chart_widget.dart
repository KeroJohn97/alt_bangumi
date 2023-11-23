import 'package:alt_bangumi/constants/color_constant.dart';
import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:alt_bangumi/models/rating_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomRatingChartWidget extends StatelessWidget {
  final RatingModel rating;
  const CustomRatingChartWidget({super.key, required this.rating});

  double _toY(int index) {
    if (rating.count == null) return 0;
    final validIndex = 10 - index;
    switch (validIndex) {
      case 1:
        return rating.count!.rate1!.toDouble();
      case 2:
        return rating.count!.rate2!.toDouble();
      case 3:
        return rating.count!.rate3!.toDouble();
      case 4:
        return rating.count!.rate4!.toDouble();
      case 5:
        return rating.count!.rate5!.toDouble();
      case 6:
        return rating.count!.rate6!.toDouble();
      case 7:
        return rating.count!.rate7!.toDouble();
      case 8:
        return rating.count!.rate8!.toDouble();
      case 9:
        return rating.count!.rate9!.toDouble();
      case 10:
        return rating.count!.rate10!.toDouble();
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                    '${rod.toY.round()}',
                    const TextStyle(
                      fontSize: 12.0,
                    ));
              },
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30.0,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text('${value.toInt()}'),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          barGroups: [
            ...List.generate(
              10,
              (index) => BarChartGroupData(
                x: 10 - index,
                barRods: [
                  BarChartRodData(
                    toY: _toY(index),
                    color: ColorConstant.themeColor,
                  )
                ],
                showingTooltipIndicators: [0],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
