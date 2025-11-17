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

  final employees = ['Lazina Pramanik', 'Lazina Pramanik', 'Lazina Pramanik', 'Lazina Pramanik', 'Lazina Pramanik'];
  final leadsMonth = [382, 350, 312, 250, 239];
  final leadsYear = [420, 390, 350, 300, 280];

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

    final currentLeads = selectedPeriod == 'Month' ? leadsMonth : leadsYear;
    final maxLead = currentLeads.reduce((a, b) => a > b ? a : b).toDouble();

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
                height: scale(34, 36, 38),
                padding: EdgeInsets.symmetric(horizontal: scale(10, 12, 14)),
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.TextformFieldsTextColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPeriod,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black),
                    items: ['Month', 'Year'].map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: TextStyle(fontSize: nameFontSize, color: Colors.black)),
                    )).toList(),
                    onChanged: (value) {
                      if (value != null && value != selectedPeriod) {
                        setState(() {
                          isExpanded = false;
                        });
                        Future.delayed(const Duration(milliseconds: 250), () {
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

          /// Horizontal Bars
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(employees.length, (index) {
              final progress = currentLeads[index] / maxLead;

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

                    ///  Bars
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
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: value,
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


