import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_adminPanel/Admin/Dashboard/Calendar%20function.dart';
import 'package:super_adminPanel/Admin/Dashboard/DashboardController.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/IconStrings.dart';

class WeeklyLeadsChart extends StatelessWidget {
  final double padding;
  final double spacing;
  final DashBoardController controller;

  const WeeklyLeadsChart({
    super.key,
    required this.padding,
    required this.spacing,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final textTheme = Theme.of(context).textTheme;

    // Scaling
    double scale(double mobile, double tablet, double web) {
      return isMobile ? mobile : isTablet ? tablet : web;
    }

    /// Chart sizing
    final chartWidth =
    isMobile || isTablet ? double.infinity : screenWidth * 0.55;
    final chartHeight = scale(180.0, 220.0, 250.0);

    /// font size
    final headingFontSize = scale(14.0, 13.0, 14.0);
    final weekFontSize = scale(8.0, 10.0, 11.0);
    final dateFontSize = scale(7.0, 8.0, 9.0);
    final barWidth = scale(12.0, 14.0, 16.0);
    final reservedSize = scale(25.0, 30.0, 35.0);

    /// Responsive spacing
    final sectionSpacing = scale(spacing * 1.2, spacing * 1.4, spacing);

    return Container(
      padding: EdgeInsets.all(padding),
      width: chartWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobileLayout = constraints.maxWidth < 400;
              return isMobileLayout
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Weekly Leads Submitted",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColors,
                      fontSize: headingFontSize,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => showCustomCalendarDialog(context),
                      child: Container(
                        height: scale(28, 32, 36),
                        width: scale(28, 32, 36),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfSearchBar,
                          borderRadius: BorderRadius.circular(scale(6, 8, 10)),
                        ),
                        child: Center(
                          child: Image.asset(
                            IconsString.calendarIcon,
                            height: scale(14, 16, 18),
                            width: scale(14, 16, 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Weekly Leads Submitted",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColors,
                      fontSize: headingFontSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showCustomCalendarDialog(context),
                    child: Container(
                      height: scale(28, 32, 36),
                      width: scale(28, 32, 36),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOfSearchBar,
                        borderRadius: BorderRadius.circular(scale(6, 8, 10)),
                      ),
                      child: Center(
                        child: Image.asset(
                          IconsString.calendarIcon,
                          height: scale(14, 16, 18),
                          width: scale(14, 16, 18),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: sectionSpacing),

          /// Date Range Navigation
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Icon
                GestureDetector(
                  onTap: controller.scrollToPrevious,
                  child: Container(
                    padding: EdgeInsets.all(scale(4, 6, 8)),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfSearchBar,
                      borderRadius: BorderRadius.circular(scale(4, 6, 8)),
                    ),
                    child: Icon(Icons.chevron_left,
                        size: scale(14, 16, 18), color: Colors.black),
                  ),
                ),
                SizedBox(width: scale(4, 6, 8)),

                // week chips
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.weeks.length, (i) {
                        final isSelected =
                            controller.selectedIndex.value == i;
                        return GestureDetector(
                          onTap: () => controller.selectWeek(i),
                          child: Container(
                            margin:
                            EdgeInsets.symmetric(horizontal: scale(2, 4, 6)),
                            padding: EdgeInsets.symmetric(
                              horizontal: scale(6, 8, 10),
                              vertical: scale(3, 4, 5),
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.backgroundOfSearchBar,
                              borderRadius:
                              BorderRadius.circular(scale(6, 8, 10)),
                            ),
                            child: Text(
                              controller.weeks[i],
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: weekFontSize,
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(width: scale(4, 6, 8)),

                // Right Icon
                GestureDetector(
                  onTap: controller.scrollToNext,
                  child: Container(
                    padding: EdgeInsets.all(scale(4, 6, 8)),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(scale(6, 8, 10)),
                    ),
                    child: Icon(Icons.chevron_right,
                        size: scale(14, 16, 18), color: Colors.white),
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: sectionSpacing),

          /// Bar Chart
          Obx(() {
            return SizedBox(
              height: chartHeight,
              width: chartWidth,
              child: BarChart(
                BarChartData(
                  maxY: 380,
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: Colors.grey.withOpacity(0.15),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(enabled: false),

                  /// Dynamic values from controller
                  barGroups: List.generate(controller.values.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: controller.values[i].toDouble(),
                          color: AppColors.primaryColor,
                          width: barWidth,
                          borderRadius:
                          BorderRadius.circular(scale(4, 4, 6)),
                        ),
                      ],
                    );
                  }),

                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int i = value.toInt();
                          if (i >= 0 && i < controller.values.length) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: scale(2, 3, 4)),
                              child: Text(
                                controller.values[i].toString(),
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: weekFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: reservedSize,
                        interval: 50,
                        getTitlesWidget: (value, _) {
                          return Text(
                            value.toInt().toString(),
                            style: textTheme.bodyMedium?.copyWith(
                                fontSize: weekFontSize),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: reservedSize + 5,
                        getTitlesWidget: (v, _) {
                          int i = v.toInt();
                          if (i < controller.days.length) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(controller.days[i],
                                    style:
                                    textTheme.bodyMedium?.copyWith(
                                      fontSize: weekFontSize,
                                    )),
                                Text(controller.dates[i],
                                    style:
                                    textTheme.bodyMedium?.copyWith(
                                      fontSize: dateFontSize,
                                      color: AppColors
                                          .TextformFieldsTextColor,
                                    )),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
