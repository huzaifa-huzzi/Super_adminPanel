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
    final valueFontSize = scale(12.0, 11.0, 12.0);
    final barHeight = scale(24.0, 26.0, 28.0);

    final numberTypes = ["Business", "Personal"];
    final values = [380.0, 220.0];
    const maxValue = 400.0;

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
          SizedBox(height: padding * 1.5),

          // Axis Labels (Left / Y-axis)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(numberTypes.length, (index) {
              final progress = values[index] / maxValue;

              return Padding(
                padding: EdgeInsets.only(bottom: scale(12, 14, 16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Lead Type label (Y-axis)
                    SizedBox(
                      width: scale(80, 100, 120),
                      child: Text(
                        numberTypes[index],
                        style: TextStyle(
                          fontSize: labelFontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    SizedBox(width: scale(8, 10, 12)),

                    /// Horizontal bar with border (X-axis top line)
                    Expanded(
                      child: Stack(
                        children: [
                          // Background bar with X-axis line
                          Container(
                            height: barHeight,
                            decoration: BoxDecoration(
                              color: AppColors.dividerColor,
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                top: BorderSide(
                                    color: Colors.black, width: 1), // X-axis
                                left: BorderSide(
                                    color: Colors.black, width: 1), // Y-axis
                              ),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: progress,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: barHeight,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              alignment: Alignment.centerRight,
                              padding:
                              EdgeInsets.only(right: scale(8, 10, 12)),
                              child: Text(
                                values[index].toStringAsFixed(0),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: valueFontSize,
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

          SizedBox(height: padding),

          // Bottom Axis - Count marks (0 to 400)
          Row(
            children: List.generate(5, (i) {
              final step = (maxValue / 4) * i; // 0, 100, 200, 300, 400
              return Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    step.toInt().toString(),
                    style: TextStyle(
                      fontSize: valueFontSize,
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
