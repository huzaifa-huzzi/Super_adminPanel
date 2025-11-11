import 'package:fl_chart/fl_chart.dart' show BarChart, BarChartData, BarTouchData, FlGridData, FlBorderData, BarChartRodStackItem, BarChartRodData, BarChartGroupData, SideTitles, AxisTitles, FlTitlesData;
import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class MissingDataChartWidget extends StatelessWidget {
  const MissingDataChartWidget({super.key});

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

    /// ---- Scaling
    final padding = scale(8.0, 9.0, 10.0);
    final titleFontSize = scale(14.0, 13.0, 14.0);
    final axisFontSize = scale(12.0, 11.0, 10.0);

    final barWidth = scale(18.0, 16.0, 18.0);
    final rodRadius = scale(8.0, 9.0, 10.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final chartHeight = scale(200.0, 190.0, 220.0);

        return Container(
          width: maxWidth,
          height: chartHeight,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---- Title
              Text(
                "Leads by Missing Data",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: padding / 2),

              /// ---- Chart
              Expanded(
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(enabled: false),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [
                        BarChartRodData(
                          toY: 6,
                          width: barWidth,
                          borderRadius: BorderRadius.circular(rodRadius),
                          rodStackItems: [
                            BarChartRodStackItem(0, 6, AppColors.rodBarColors),
                            BarChartRodStackItem(0, 3, AppColors.primaryColor),
                          ],
                          borderSide: BorderSide.none,
                        ),
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(
                          toY: 6,
                          width: barWidth,
                          borderRadius: BorderRadius.circular(rodRadius),
                          rodStackItems: [
                            BarChartRodStackItem(0, 6, AppColors.rodBarColors),
                            BarChartRodStackItem(0, 4, AppColors.primaryColor),
                          ],
                          borderSide: BorderSide.none,
                        ),
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(
                          toY: 6,
                          width: barWidth,
                          borderRadius: BorderRadius.circular(rodRadius),
                          rodStackItems: [
                            BarChartRodStackItem(0, 6, AppColors.rodBarColors),
                            BarChartRodStackItem(0, 2, AppColors.primaryColor),
                          ],
                          borderSide: BorderSide.none,
                        ),
                      ]),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (v, _) {
                            return Text(
                              "${v.toInt() + 1}",
                              style: TextStyle(
                                fontSize: axisFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (v, _) {
                            String label = "";
                            switch (v.toInt()) {
                              case 0:
                                label = "Website";
                                break;
                              case 1:
                                label = "Phone";
                                break;
                              case 2:
                                label = "Email";
                                break;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: axisFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColors,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
