import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class LeadsByEmployeeWidget extends StatelessWidget {
  const LeadsByEmployeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    double scale(double mobile, double tablet, double web) =>
        isMobile ? mobile : isTablet ? tablet : web;

    final padding = scale(12, 16, 20);
    final titleFontSize = scale(14, 15, 16);
    final nameFontSize = scale(11, 12, 13);
    final valueFontSize = scale(10, 11, 12);
    final barHeight = scale(26, 28, 30);
    final avatarRadius = scale(14, 16, 18);

    final employees = [
      'Lazina Pramanik',
      'Lazina Pramanik',
      'Lazina Pramanik',
      'Lazina Pramanik',
      'Lazina Pramanik',
    ];

    final leads = [382, 350, 312, 250, 239];
    final maxLead = leads.reduce((a, b) => a > b ? a : b).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Leads by Employee',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColors,
                ),
              ),
              Container(
                height: scale(34, 36, 38),
                padding: EdgeInsets.symmetric(horizontal: scale(10, 12, 14)),
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.TextformFieldsTextColor),
                ),
                child: Row(
                  children: [
                    Text(
                      'Month',
                      style: TextStyle(
                        fontSize: nameFontSize,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 18,color: Colors.black,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: padding),

          /// Horizontal Bars List
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(employees.length, (index) {
              final progress = leads[index] / maxLead;

              return Padding(
                padding: EdgeInsets.only(bottom: scale(10, 12, 14)),
                child: Row(
                  children: [
                    /// Employee Name
                    Text(
                      employees[index],
                      style: TextStyle(
                        fontSize: nameFontSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(width: scale(10, 12, 14)),

                    /// Avatar
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.grey.shade300,
                    ),

                    SizedBox(width: scale(16, 20, 24)),

                    /// Blue Progress Bar
                    Expanded(
                      child: Stack(
                        children: [
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
                              padding: EdgeInsets.only(right: scale(8, 10, 12)),
                              child: Text(
                                leads[index].toString(),
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
        ],
      ),
    );
  }
}
