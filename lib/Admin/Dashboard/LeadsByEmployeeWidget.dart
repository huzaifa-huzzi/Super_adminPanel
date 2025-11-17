import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class LeadsByEmployeeWidget extends StatefulWidget {
  const LeadsByEmployeeWidget({super.key});

  @override
  State<LeadsByEmployeeWidget> createState() => _LeadsByEmployeeWidgetState();
}

class _LeadsByEmployeeWidgetState extends State<LeadsByEmployeeWidget> {
  String selectedPeriod = 'Month';
  bool isExpanded = true;

  final employees = [
    'Lazina Pramanik',
    'Lazina Pramanik',
    'Lazina Pramanik',
    'Lazina Pramanik',
    'Lazina Pramanik'
  ];
  final leadsMonth = [382, 350, 312, 250, 239];
  final leadsYear = [420, 390, 350, 300, 280];

  // Responsive scaling function
  double scaleValue(BuildContext context, double mobile, double tablet, double web) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return mobile;
    if (width < 1024) return tablet;
    return web;
  }

  @override
  Widget build(BuildContext context) {
    final padding = scaleValue(context, 12, 16, 20);
    final titleFontSize = scaleValue(context, 14, 15, 16);
    final nameFontSize = scaleValue(context, 11, 12, 13);
    final valueFontSize = scaleValue(context, 10, 11, 12);
    final barHeight = scaleValue(context, 26, 28, 30);
    final avatarRadius = scaleValue(context, 14, 16, 18);
    final spacingBetweenRows = scaleValue(context, 10, 12, 14);
    final spacingBetweenElements = scaleValue(context, 10, 12, 16);

    final currentLeads = selectedPeriod == 'Month' ? leadsMonth : leadsYear;
    final maxLead = currentLeads.reduce((a, b) => a > b ? a : b).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(scaleValue(context, 12, 14, 16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row with Dropdown
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
                height: scaleValue(context, 34, 36, 38),
                padding: EdgeInsets.symmetric(horizontal: scaleValue(context, 10, 12, 14)),
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(scaleValue(context, 6, 8, 10)),
                  border: Border.all(color: AppColors.TextformFieldsTextColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPeriod,
                    icon: Icon(Icons.keyboard_arrow_down, size: scaleValue(context, 18, 20, 22), color: Colors.black),
                    items: ['Month', 'Year'].map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(fontSize: nameFontSize, color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null && value != selectedPeriod) {
                        setState(() => isExpanded = false);
                        Future.delayed(Duration(milliseconds: 250), () {
                          setState(() {
                            selectedPeriod = value;
                            isExpanded = true;
                          });
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacingBetweenElements),

          /// Horizontal Bars
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(employees.length, (index) {
              final progress = currentLeads[index] / maxLead;

              return Padding(
                padding: EdgeInsets.only(bottom: spacingBetweenRows),
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

                    SizedBox(width: spacingBetweenElements),

                    /// Avatar
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.grey.shade300,
                    ),

                    SizedBox(width: spacingBetweenElements * 1.5),

                    /// Animated Bars
                    Expanded(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: isExpanded ? progress : 0),
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Stack(
                            children: [
                              Container(
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: AppColors.dividerColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(barHeight / 2),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: value,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(barHeight / 2),
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: scaleValue(context, 8, 10, 12)),
                                  child: Text(
                                    currentLeads[index].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: valueFontSize,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
