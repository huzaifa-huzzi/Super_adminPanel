import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class NumberTypesWidget extends StatelessWidget {
  const NumberTypesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    double scale(double mobile, double tablet, double web) =>
        isMobile ? mobile : isTablet ? tablet : web;

    final padding = scale(8.0, 10.0, 12.0);
    final titleFontSize = scale(14.0, 13.0, 14.0);
    final labelFontSize = scale(12.0, 11.0, 12.0);

    final barHeight = scale(18.0, 20.0, 22.0);
    final values = [350.0, 220.0];
    const maxValue = 400.0;

    final numberTypes = ["Business", "Personal"];

    final xAxisBottom = scale(20, 24, 28);
    final yAxisLeft = scale(45, 75, 85);
    final labelWidth = scale(55, 70, 90);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Number Type",
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textColors,
            ),
          ),
          SizedBox(height: padding * 3),

          Stack(
            children: [
              // Y-axis line
              Positioned(
                top: 0,
                bottom: xAxisBottom,
                left: yAxisLeft,
                child: Container(
                  width: 1,
                  color: Colors.black,
                ),
              ),

              // X-axis
              Positioned(
                left: yAxisLeft,
                right: 0,
                bottom: xAxisBottom,
                child: Container(
                  height: 1,
                  color: Colors.black,
                ),
              ),

              // Vertical "LEAD" text (shared for both bars)
              Positioned(
                top: 0,
                bottom: xAxisBottom + scale(10, 12, 14),
                left: yAxisLeft - scale(25, 30, 35), // thoda gap left se
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "LEAD",
                    style: TextStyle(
                      fontSize: labelFontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // Bars
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  bottom: xAxisBottom + scale(10, 12, 14),
                  right: scale(10, 12, 14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(numberTypes.length, (index) {
                    final progress = values[index] / maxValue;

                    return Padding(
                      padding: EdgeInsets.only(bottom: scale(8, 10, 12)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Y-axis label
                          SizedBox(
                            width: labelWidth,
                            child: Text(
                              numberTypes[index],
                              style: TextStyle(
                                fontSize: labelFontSize,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: scale(4, 6, 8)),

                          // Bar
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: progress,
                                child: Container(
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),

          SizedBox(height: scale(8, 10, 12)),

          // Counts
          Padding(
            padding: EdgeInsets.only(left: yAxisLeft - scale(15, 15, 15)),
            child: Row(
              children: List.generate(5, (i) {
                final step = maxValue - (maxValue / 4) * i;
                return Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: scale(4, 6, 8)),
                    child: Text(
                      step.toInt().toString(),
                      style: TextStyle(
                        fontSize: labelFontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold, // bold counts
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
