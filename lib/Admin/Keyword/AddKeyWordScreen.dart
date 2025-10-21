import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:super_adminPanel/Admin/Keyword/KeyWordController.dart' show KeywordController;
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/IconStrings.dart';
import 'package:super_adminPanel/Resources/String.dart';

class AddKeywordScreen extends StatelessWidget {
  AddKeywordScreen({super.key});

  final controller = Get.put(KeywordController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Device types
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1000;

    // Scale
    double scale(double mobile, double tablet, double web) {
      return isMobile
          ? mobile
          : isTablet
          ? tablet
          : web;
    }

    // Font sizes
    final double titleFontSize = scale(18, 20, 22);
    final double subtitleFontSize = scale(12, 14, 15);
    final double labelFontSize = scale(12, 13, 14);
    final double inputFontSize = scale(12, 13, 14);
    final double buttonFontSize = scale(13, 14, 15);

    // Button Height
    final double buttonHeight = scale(
      screenHeight * 0.055,
      screenHeight * 0.06,
      screenHeight * 0.065,
    );

    // Container Max Width
    double containerMaxWidth = isMobile
        ? screenWidth * 0.95
        : isTablet
        ? screenWidth * 0.7
        : screenWidth * 0.5;

    // Padding
    double paddingAll = scale(12, 14, 16);

    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: scale(12, 16, 20),
          vertical: scale(10, 12, 14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              TextStrings.keywordTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: scale(6, 8, 10)),
            Text(
              TextStrings.addKeyWordSubTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: subtitleFontSize,
              ),
            ),
            SizedBox(height: scale(20, 24, 28)),

            /// Container
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: containerMaxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Form Container
                  Container(
                    padding: EdgeInsets.all(paddingAll),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Colors.black12,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(IconsString.personIcon,
                                width: scale(16, 18, 20),
                                height: scale(16, 18, 20)),
                            SizedBox(width: scale(6, 8, 10)),
                            Text("Keyword Category Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: labelFontSize)),
                          ],
                        ),
                        SizedBox(height: scale(8, 10, 12)),
                        TextFormField(
                          controller: controller.keywordCategoryNameController,
                          focusNode: controller.keywordCategoryNameNode,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black, fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Enter keyword Category Name",
                            hintStyle: TextStyle(
                                color: AppColors.captionsColor,
                                fontSize: inputFontSize),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: AppColors.captionsColor, width: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: scale(16, 18, 20)),

                  /// Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Cancel Button
                      SizedBox(
                        height: buttonHeight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundOfLogoutColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  scale(4, 6, 8)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: scale(20, 24, 28)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontSize: buttonFontSize,
                              color: AppColors.redColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: scale(12, 14, 16)),

                      // Add Button
                      SizedBox(
                        height: buttonHeight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  scale(4, 6, 8)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: scale(20, 24, 28)),
                          ),
                          onPressed: () {
                            context.go('/keyword');
                          },
                          child: Text(
                            "Add",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontSize: buttonFontSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
