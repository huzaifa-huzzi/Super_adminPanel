import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_adminPanel/Admin/Form/FormController.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/String.dart';
import 'package:super_adminPanel/Resources/textTheme.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  double scaleFor(BuildContext context, double desktop, double tablet, double mobile) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1000) return desktop;
    if (width >= 600) return tablet;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormController());
    final textTheme = TTextTheme.lightTextTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1000;
    final bool isMobile = screenWidth < 600;

    double scale(double mobile, double tablet, double web) {
      return isMobile ? mobile : isTablet ? tablet : web;
    }

    final double titleFontSize = scale(18, 20, 22);
    final double subtitleFontSize = scale(12, 14, 15);
    final double labelFontSize = scale(12, 13, 14);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextStrings.formTitle,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: scaleFor(context, 4, 4, 3)),
                        Text(
                          TextStrings.formSubtitle,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: subtitleFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isMobile || isTablet
                      ? Container(
                    height: scaleFor(context, 38, 36, 34),
                    width: scaleFor(context, 38, 36, 34),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfSearchBar,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add,
                          color: AppColors.textColors,
                          size: scaleFor(context, 20, 18, 17)),
                      onPressed: () {},
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
                    icon: Icon(Icons.add,
                        color: Colors.white,
                        size: scaleFor(context, 18, 17, 16)),
                    label: Text(
                      "Download Now",
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: labelFontSize,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),

              SizedBox(height: scaleFor(context, 30, 25, 18)),

              Center(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 1600),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scaleFor(context, 20, 18, 14)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          TextStrings.employeeContainerTitle,
                          style: textTheme.headlineSmall?.copyWith(
                            fontSize: labelFontSize,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: scaleFor(context, 20, 18, 14)),

                      /// HORIZONTAL SCROLL VIEW
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            /// HEADER ROW
                            Container(
                              color: AppColors.rodBarColors,
                              padding:
                              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Row(
                                children: [
                                  buildHeader("Sn", labelFontSize),
                                  buildHeader("Keyword Category", labelFontSize),
                                  buildHeader("Keyword Title", labelFontSize),
                                  buildHeader("Name", labelFontSize),
                                  buildHeader("Number Type", labelFontSize),
                                  buildHeader("Phone Number", labelFontSize),
                                  buildHeader("Email", labelFontSize),
                                  buildHeader("Website", labelFontSize),
                                  buildHeader("Country", labelFontSize),
                                  buildHeader("State", labelFontSize),
                                  buildHeader("City", labelFontSize),
                                  buildHeader("Suburb", labelFontSize),
                                  buildHeader("Zip Code", labelFontSize),
                                  buildHeader("Address", labelFontSize),
                                  buildHeader("Submitted By", labelFontSize),
                                ],
                              ),
                            ),

                            /// DATA ROWS
                            Obx(() {
                              return Column(
                                children: controller.forms.map((item) {
                                  final index = controller.forms.indexOf(item);
                                  final isHighlighted = index % 2 == 0;
                                  return Container(
                                    color: isHighlighted
                                        ? AppColors.rodBarColors.withOpacity(0.3)
                                        : Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    child: Row(
                                      children: [
                                        buildCell(item['Sn'], smallTextSize),
                                        buildCell(item['Keyword Category'], smallTextSize),
                                        buildCell(item['Keyword Title'], smallTextSize),
                                        buildCell(item['Name'], smallTextSize),
                                        buildCell(item['Number Type'], smallTextSize),
                                        buildCell(item['Number'], smallTextSize),
                                        buildCell(item['Email'], smallTextSize,
                                            noWrap: true),
                                        buildCell(item['Website'], smallTextSize,
                                            noWrap: true),
                                        buildCell(item['Country'], smallTextSize),
                                        buildCell(item['State'], smallTextSize),
                                        buildCell(item['City'], smallTextSize),
                                        buildCell(item['Suburb'], smallTextSize),
                                        buildCell(item['Zip Code'], smallTextSize),
                                        buildCell(item['Address'], smallTextSize),
                                        buildCell(item['Submitted By'], smallTextSize),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: scaleFor(context, 20, 18, 14)),
              /// Pagination
              Obx(() {
                final currentPage = controller.currentPage.value;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.keyboard_double_arrow_left,
                              color: AppColors.textColors, size: smallTextSize),
                          onPressed: controller.previousPage,
                        ),
                      ),
                      for (int i = 1; i <= 5; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () => controller.goToPage(i),
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.keyboard_double_arrow_right,
                              color: Colors.white, size: smallTextSize),
                          onPressed: controller.nextPage,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

   /// -------------- Extra Widgets ------------------///

  Widget buildHeader(String text, double fontSize) {
    return SizedBox(
      width: 120,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textColors,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget buildCell(String? text, double fontSize, {bool noWrap = false}) {
    return SizedBox(
      width: 120,
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        overflow: noWrap ? TextOverflow.ellipsis : TextOverflow.visible,
        maxLines: noWrap ? 1 : null,
        softWrap: !noWrap,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textColors,
        ),
      ),
    );
  }


  Widget paginationButton(IconData icon,
      {Color? color, Color? iconColor, required VoidCallback onTap}) {
    return Container(
      height: 24,
      width: 24,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: iconColor ?? AppColors.textColors, size: 14),
        onPressed: onTap,
      ),
    );
  }
}
