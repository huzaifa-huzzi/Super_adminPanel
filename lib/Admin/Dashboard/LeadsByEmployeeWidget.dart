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
  double scale(BuildContext context, double mobile, double tablet, double web) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return mobile;
    if (width < 1024) return tablet;
    return web;
  }

  @override
  Widget build(BuildContext context) {
    // Scaling all parameters
    final padding = scale(context, 12, 16, 20);
    final containerRadius = scale(context, 12, 14, 16);
    final titleFontSize = scale(context, 16, 18, 20);
    final nameFontSize = scale(context, 12, 14, 16);
    final valueFontSize = scale(context, 10, 12, 14);
    final barHeight = scale(context, 28, 32, 36);
    final avatarRadius = scale(context, 16, 18, 20);
    final spacingRows = scale(context, 12, 14, 16);
    final spacingColumns = scale(context, 10, 12, 14);
    final dropdownHeight = scale(context, 36, 38, 40);
    final dropdownPadding = scale(context, 12, 14, 16);
    final dropdownRadius = scale(context, 6, 8, 10);
    final dropdownIconSize = scale(context, 18, 20, 22);

    final currentLeads = selectedPeriod == 'Month' ? leadsMonth : leadsYear;
    final maxLead = currentLeads.reduce((a, b) => a > b ? a : b).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(containerRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header: Text + Dropdown
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
                height: dropdownHeight,
                padding: EdgeInsets.symmetric(horizontal: dropdownPadding),
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(dropdownRadius),
                  border: Border.all(color: AppColors.TextformFieldsTextColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPeriod,
                    icon: Icon(Icons.keyboard_arrow_down, size: dropdownIconSize, color: Colors.black),
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
                        Future.delayed(const Duration(milliseconds: 300), () {
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
          SizedBox(height: padding),

          /// Employee Bars
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(employees.length, (index) {
              final progress = currentLeads[index] / maxLead;
              return Padding(
                padding: EdgeInsets.only(bottom: spacingRows),
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

                    SizedBox(width: spacingColumns),

                    /// Avatar
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.grey.shade300,
                    ),

                    SizedBox(width: spacingColumns),

                    /// Animated Bar
                    Expanded(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: isExpanded ? progress : 0),
                        duration: const Duration(milliseconds: 600),
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
                                  padding: EdgeInsets.only(right: scale(context, 8, 10, 12)),
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
