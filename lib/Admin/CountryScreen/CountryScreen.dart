import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:super_adminPanel/Admin/CountryScreen/CountryController.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/IconStrings.dart';
import 'package:super_adminPanel/Resources/String.dart';
import 'package:super_adminPanel/Resources/textTheme.dart';



class CountryScreen extends StatelessWidget {
  const CountryScreen({super.key});

  double scaleFor(BuildContext context, double desktop, double tablet, double mobile) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1000) return desktop;
    if (width >= 600) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CountryController());
    final textTheme = TTextTheme.lightTextTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1000;
    final bool isMobile = screenWidth < 600;

    // Scale function
    double scale(double mobile, double tablet, double web) {
      return isMobile ? mobile : isTablet ? tablet : web;
    }

    // Font sizes
    final double titleFontSize = scale(18, 20, 22);
    final double subtitleFontSize = scale(12, 14, 15);
    final double labelFontSize = scale(12, 13, 14);
    final double inputFontSize = scale(12, 13, 14);
    final double buttonFontSize = scale(13, 14, 15);
    final double smallTextSize = scale(10, 11, 12);

    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: scaleFor(context, 50, 30, 16),
            vertical: scaleFor(context, 25, 20, 12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Padding(
                padding: EdgeInsets.only(bottom: scaleFor(context, 6, 8, 10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// LEFT SIDE
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextStrings.countryTitle,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: scaleFor(context, 4, 4, 3)),
                          Text(
                            TextStrings.countrySubTitle,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: subtitleFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// ADD BUTTON
                    isMobile || isTablet
                        ? Container(
                      height: scaleFor(context, 38, 36, 34),
                      width: scaleFor(context, 38, 36, 34),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOfSearchBar,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: AppColors.textColors,
                          size: scaleFor(context, 20, 18, 17),
                        ),
                        onPressed: () => context.go('/addCountry'),
                      ),
                    )
                        : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleFor(context, 18, 16, 14),
                          vertical: scaleFor(context, 10, 9, 8),
                        ),
                      ),
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: scaleFor(context, 18, 17, 16),
                      ),
                      label: Text(
                        "Add country",
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: buttonFontSize,
                        ),
                      ),
                      onPressed: () => context.go('/addCountry'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: scaleFor(context, 20, 18, 14)),

              /// TABLE
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: scaleFor(context, 600, 550, 500),
                  margin: EdgeInsets.only(top: scaleFor(context, 6, 6, 4)),
                  padding: EdgeInsets.symmetric(
                    horizontal: scaleFor(context, 16, 14, 12),
                    vertical: scaleFor(context, 14, 12, 10),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Table Title
                      Padding(
                        padding: EdgeInsets.only(bottom: scaleFor(context, 10, 8, 6)),
                        child: Text(
                          TextStrings.countryContainerTitle,
                          style: textTheme.headlineSmall?.copyWith(
                            fontSize: labelFontSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      /// Header Row
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleFor(context, 10, 8, 6),
                          vertical: scaleFor(context, 10, 8, 6),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.rodBarColors,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "SN",
                                style: TextStyle(
                                  color: AppColors.textColors,
                                  fontWeight: FontWeight.w600,
                                  fontSize: labelFontSize,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                'Country',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textColors,
                                  fontWeight: FontWeight.w600,
                                  fontSize: labelFontSize,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Actions",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: AppColors.textColors,
                                  fontWeight: FontWeight.w600,
                                  fontSize: labelFontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: scaleFor(context, 8, 8, 6)),

                      /// DATA ROWS
                      Obx(() {
                        return Column(
                          children: controller.keywordCategories.map((item) {
                            final index = controller.keywordCategories.indexOf(item);
                            final isHighlighted = index % 2 == 0;

                            final bool isAustralia = (item['category'] ?? '').toLowerCase() == 'australia';

                            return Container(
                              margin: EdgeInsets.only(bottom: scaleFor(context, 6, 5, 4)),
                              padding: EdgeInsets.symmetric(
                                horizontal: scaleFor(context, 10, 8, 6),
                                vertical: scaleFor(context, 8, 7, 6),
                              ),
                              decoration: BoxDecoration(
                                color: isHighlighted
                                    ? AppColors.rodBarColors
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      item['Sn'] ?? '',
                                      style: TextStyle(
                                        fontSize: smallTextSize,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColors,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      item['category'] ?? '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: smallTextSize,
                                        fontWeight: FontWeight.bold,
                                        color: isAustralia
                                            ? AppColors.primaryColor
                                            : AppColors.textColors,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () => controller.deleteKeyword(index),
                                        child: Container(
                                          height: scaleFor(context, 18, 17, 16),
                                          width: scaleFor(context, 18, 17, 16),
                                          decoration: BoxDecoration(
                                            color: AppColors.dividerColor,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Image.asset(
                                            IconsString.deleteIcon,
                                            width: scaleFor(context, 9.5, 9, 8.5),
                                            height: scaleFor(context, 9.5, 9, 8.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              SizedBox(height: scaleFor(context, 20, 18, 14)),

              /// PAGINATION
              Obx(() {
                final currentPage = controller.currentPage.value;

                return Row(
                  children: [
                    Text(
                      "1–05 of 10 items",
                      style: TextStyle(
                        fontSize: smallTextSize,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColors,
                      ),
                    ),
                    SizedBox(width: scaleFor(context, 6, 5.5, 5)),

                    /// Previous
                    Container(
                      height: scaleFor(context, 24, 22, 20),
                      width: scaleFor(context, 24, 22, 20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.keyboard_double_arrow_left,
                          color: AppColors.textColors,
                          size: smallTextSize,
                        ),
                        onPressed: controller.previousPage,
                      ),
                    ),

                    /// Page Numbers
                    for (int i = 1; i <= 5; i++)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleFor(context, 2.5, 2, 1.5),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () => controller.goToPage(i),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleFor(context, 6, 5.5, 5),
                              vertical: scaleFor(context, 3.2, 3, 2.6),
                            ),
                            decoration: BoxDecoration(
                              color: currentPage == i
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: currentPage == i
                                    ? AppColors.primaryColor
                                    : Colors.black12,
                              ),
                            ),
                            child: Text(
                              "$i",
                              style: TextStyle(
                                color: currentPage == i
                                    ? Colors.white
                                    : AppColors.textColors,
                                fontWeight: FontWeight.w600,
                                fontSize: smallTextSize,
                              ),
                            ),
                          ),
                        ),
                      ),

                    /// Next
                    Container(
                      height: scaleFor(context, 24, 22, 20),
                      width: scaleFor(context, 24, 22, 20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Colors.white,
                          size: smallTextSize,
                        ),
                        onPressed: controller.nextPage,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}