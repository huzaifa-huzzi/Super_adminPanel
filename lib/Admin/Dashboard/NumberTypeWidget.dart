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

    // X-axis position
    final xAxisBottom = scale(20, 24, 28);


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

              Positioned(
                top: 0,
                bottom: xAxisBottom - scale(4, 4, 4),
                left: scale(80, 100, 110),
                child: Container(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              // X-axis
              Positioned(
                left: scale(80, 100, 110),
                right: 0,
                bottom: xAxisBottom,
                child: Container(
                  height: 1,
                  color: Colors.black,
                ),
              ),


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
                      padding: EdgeInsets.only(bottom: scale(12, 14, 16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Y-axis label
                          SizedBox(
                            width: scale(80, 100, 110),
                            child: Text(
                              numberTypes[index],
                              style: TextStyle(
                                fontSize: labelFontSize,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: scale(10, 12, 14)),

                          // Bars
                          Expanded(
                            child: Stack(
                              children: [

                                Align(
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
                              ],
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

          // Counts
          Padding(
            padding: EdgeInsets.only(left: scale(50, 70, 90)),
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
                        fontWeight: FontWeight.w500,
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
