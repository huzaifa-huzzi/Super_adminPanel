import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class StatesPieChartWidget extends StatelessWidget {
  const StatesPieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    double scale(double mobile, double tablet, double web) {
      return isMobile
          ? mobile
          : isTablet
          ? tablet
          : web;
    }

    /// ---- Mobile
    final padding = scale(8.0, 9.0, 10.0);
    final chartHeight = scale(180.0, 230.0, 250.0);
    final headingFontSize = scale(14.0, 13.0, 14.0);
    final legendFontSize = scale(12.0, 11.0, 12.0);
    final pieRadius =
    isMobile ? chartHeight * 0.28 : chartHeight * 0.32;
    final pieTextFontSize = scale(11.0, 11.0, 12.0);

    final maxWidth = isMobile || isTablet ? double.infinity : 400.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: maxWidth,
            padding: EdgeInsets.all(padding),
            height: chartHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Text(
                  "Leads by States",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: headingFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: padding / 2),

                // Pie Chart
                Expanded(
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 0,
                      sectionsSpace: 0,
                      sections: [
                        _pieSection(35, Colors.lightBlue, pieRadius, pieTextFontSize),
                        _pieSection(20, Colors.blue, pieRadius, pieTextFontSize),
                        _pieSection(20, Colors.green, pieRadius, pieTextFontSize),
                        _pieSection(10, Colors.orange, pieRadius, pieTextFontSize),
                        _pieSection(5, Colors.red, pieRadius, pieTextFontSize),
                        _pieSection(10, Colors.purple, pieRadius, pieTextFontSize),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: padding / 2),

                // Legends
                Wrap(
                  spacing: padding * 1.5,
                  runSpacing: padding / 2,
                  children: [
                    _legendItem(Colors.red, "NSW", legendFontSize),
                    _legendItem(Colors.green, "VIC", legendFontSize),
                    _legendItem(Colors.blue, "QLD", legendFontSize),
                    _legendItem(Colors.orange, "SA", legendFontSize),
                    _legendItem(Colors.lightBlue, "WA", legendFontSize),
                    _legendItem(Colors.purple, "TAS", legendFontSize),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------- Extra widgets ---------- //
  PieChartSectionData _pieSection(
      double value, Color color, double radius, double fontSize) {
    return PieChartSectionData(
      value: value,
      color: color,
      radius: radius,
      title: "${value.toInt()}%",
      titleStyle: TextStyle(
        color: AppColors.textColors,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }

  Widget _legendItem(Color color, String text, double fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: fontSize + 2,
          height: fontSize + 2,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: fontSize * 0.6),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
