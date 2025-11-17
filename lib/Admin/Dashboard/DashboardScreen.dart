import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:super_adminPanel/Admin/Dashboard/DashboardController.dart';
import 'package:super_adminPanel/Admin/Dashboard/KeywordCategoryWidget.dart';
import 'package:super_adminPanel/Admin/Dashboard/LeadsByEmployeeWidget.dart';
import 'package:super_adminPanel/Admin/Dashboard/MissingChartDataWidget.dart';
import 'package:super_adminPanel/Admin/Dashboard/NumberTypeWidget.dart';
import 'package:super_adminPanel/Admin/Dashboard/StatePieChartWidget.dart';
import 'package:super_adminPanel/Admin/Dashboard/WeakLeadsDataWidget.dart';
import 'package:super_adminPanel/Admin/Sidebar/SidebarController.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/String.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = Get.put(DashBoardController());
    final height = MediaQuery.of(context).size.height;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final textTheme = Theme.of(context).textTheme;

    //  scaling function
    double scale(double mobile, double tablet, double web) {
      return isMobile
          ? mobile
          : isTablet
          ? tablet
          : web;
    }

    final padding = scale(8, 10, 12);
    final spacing = scale(8, 10, 12);
    final headingFontSize = scale(18, 20, 22);
    final cardTitleFont = scale(12, 14, 15);
    final cardValueFont = scale(16, 18, 20);

    //  spacing for sections (only mobile/tablet)
    final sectionSpacing = isMobile
        ? 24.0
        : isTablet
        ? 32.0
        : 16.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ---------- TOP BAR ----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextStrings.dashboardTitle,
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: headingFontSize,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            TextStrings.dashboardSubtitle,
                            style: textTheme.titleSmall?.copyWith(
                              fontSize: scale(12, 13, 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: scale(4, 6, 10)),
                        isMobile || isTablet
                            ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.backgroundOfSearchBar,
                            borderRadius:
                            BorderRadius.circular(scale(6, 8, 10)),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: AppColors.textColors,
                              size: scale(20, 22, 24),
                            ),
                            onPressed: () {
                              final sidebarController =
                              Get.find<Sidebarcontroller>();
                              sidebarController.selectedIndex.value = 1;
                              GoRouter.of(context).go('/form');
                            },
                          ),
                        )
                            : ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(scale(3, 4, 5)),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: scale(10, 12, 14),
                              vertical: scale(8, 10, 12),
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: scale(16, 18, 20),
                          ),
                          label: Text(
                            "Add Leads",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontSize: scale(13, 14, 15),
                            ),
                          ),
                          onPressed: () {
                            final sidebarController =
                            Get.find<Sidebarcontroller>();
                            sidebarController.selectedIndex.value = 1;
                            GoRouter.of(context).go('/form');
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: sectionSpacing),

                /// ---------- TOP CARDS ----------
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: isMobile ? 3 : 2,
                  children: [
                    _summaryCard(
                        context,
                        "Total Leads",
                        "48000",
                        AppColors.backgroundOfTotalLeads,
                        cardTitleFont,
                        cardValueFont),
                    _summaryCard(
                        context,
                        "Today Leads",
                        "200",
                        AppColors.backgroundOfTodayLeads,
                        cardTitleFont,
                        cardValueFont),
                    _summaryCard(
                        context,
                        "This Week Leads",
                        "3000",
                        AppColors.backgroundOfWeeksLeads,
                        cardTitleFont,
                        cardValueFont),
                    _summaryCard(
                        context,
                        "This Month Leads",
                        "6000",
                        AppColors.backgroundOfMonthLeads,
                        cardTitleFont,
                        cardValueFont),
                  ],
                ),
                SizedBox(height: sectionSpacing),


                /// ---------- SECOND ROW ----------
              if (isMobile || isTablet)
                SingleChildScrollView(
                  padding: EdgeInsets.all(sectionSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Missing Data Chart
                      SizedBox(
                        height: 250,
                        child: MissingDataChartWidget(),
                      ),
                      SizedBox(height: sectionSpacing),

                      ///  States Pie Chart
                      SizedBox(
                        height: 250,
                        child: StatesPieChartWidget(),
                      ),
                      SizedBox(height: sectionSpacing),

                      ///  Weekly Leads Chart
                      SizedBox(
                        height: 380,
                        child: WeeklyLeadsChart(
                          padding: padding,
                          spacing: spacing,
                          controller: controller,
                        ),
                      ),
                      SizedBox(height: sectionSpacing),

                      ///  Keyword Category
                      SizedBox(
                        height: 450,
                        child: KeywordCategoryWidget(),
                      ),
                      SizedBox(height: sectionSpacing),

                      ///  Leads By Employee
                      SizedBox(
                        height: 360,
                        child: LeadsByEmployeeWidget(),
                      ),
                      SizedBox(height: sectionSpacing),

                      ///  Number Types
                      SizedBox(
                        height: 260,
                        child: NumberTypesWidget(),
                      ),
                    ],
                  ),
                )

              else
                  SingleChildScrollView(
                    padding: EdgeInsets.all(spacing),
                    child: Stack(
                      children: [

                        /// -------- Main Column --------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 250,
                                    child: MissingDataChartWidget(),
                                  ),
                                ),

                                SizedBox(width: spacing * 0.5),

                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 250,
                                    child: StatesPieChartWidget(),
                                  ),
                                ),

                                SizedBox(width: spacing * 0.5),

                                Flexible(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 590,
                                    child: KeywordCategoryWidget(),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 100),

                            /// -------- Leads By Employee(Widget) --------
                            SizedBox(
                              height: 400,
                              width: screenWidth,
                              child: LeadsByEmployeeWidget(),
                            ),

                            SizedBox(height: spacing * 2),

                            /// -------- Number Types(Widget) --------
                            SizedBox(
                              height: 260,
                              width: screenWidth,
                              child: NumberTypesWidget(),
                            ),
                          ],
                        ),

                        /// -------- Weekly Leads Chart(Widget) --------
                        Positioned(
                          top: 250 + spacing * 1,
                          left: spacing,
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            height: 380,
                            child: WeeklyLeadsChart(
                              padding: padding,
                              spacing: spacing,
                              controller: controller,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }


  /// ---------- SUMMARY CARD ----------
  Widget _summaryCard(BuildContext context, String title, String value,
      Color color, double titleFont, double valueFont) {
    final textTheme = Theme.of(context).textTheme;

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    double padding = isMobile ? 8 : isTablet ? 10 : 12;
    double borderRadius = isMobile ? 8 : isTablet ? 10 : 12;
    double titleFontAdjusted =
    isMobile ? titleFont * 0.85 : isTablet ? titleFont * 0.9 : titleFont;
    double valueFontAdjusted =
    isMobile ? valueFont * 0.85 : isTablet ? valueFont * 0.9 : valueFont;
    double cardHeight = isMobile ? 80 : isTablet ? 100 : 120;

    return Container(
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      height: cardHeight,
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: titleFontAdjusted,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: padding / 2),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              fontSize: valueFontAdjusted,
              fontWeight: FontWeight.bold,
              color: AppColors.textColors,
            ),
          ),
        ],
      ),
    );
  }
}
