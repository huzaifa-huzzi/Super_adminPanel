import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class KeywordCategoryWidget extends StatelessWidget {
  const KeywordCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    double scale(double mobile, double tablet, double web) {
      return isMobile
          ? mobile
          : isTablet
          ? tablet
          : web;
    }

    /// ---- Scaling
    final padding = scale(8.0, 10.0, 12.0);
    final titleFontSize = scale(14.0, 13.0, 14.0);
    final headerFontSize = scale(13.0, 12.0, 13.0);
    final rowFontSize = scale(12.0, 11.0, 12.0);
    final rowHeight = scale(42.0, 40.0, 45.0);

    final maxWidth = screenWidth;

    final containerHeight = isMobile
        ? screenHeight * 0.9
        : isTablet
        ? screenHeight * 0.95
        : screenHeight * 0.98;

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: maxWidth,
        height: containerHeight,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---- Title
            Text(
              "Leads by Keyword Category",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.textColors,
              ),
            ),
            SizedBox(height: padding / 2),

            /// ---- Subheading Row
            Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Keyword",
                      style: TextStyle(
                        fontSize: headerFontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Leads",
                        style: TextStyle(
                          fontSize: headerFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ---- Scrollable List
            Expanded(
              child: ListView.separated(
                itemCount: 30,
                separatorBuilder: (_, __) =>
                    Divider(color: AppColors.dividerColor),
                itemBuilder: (context, i) {
                  return Container(
                    height: rowHeight,
                    padding: EdgeInsets.symmetric(vertical: padding / 6),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Demo",
                            style: TextStyle(
                              fontSize: rowFontSize,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${(i + 1) * 2}",
                              style: TextStyle(
                                fontSize: rowFontSize,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
