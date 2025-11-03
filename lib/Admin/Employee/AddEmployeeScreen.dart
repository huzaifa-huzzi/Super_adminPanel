import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:super_adminPanel/Admin/CityScreen/CityController.dart';
import 'package:super_adminPanel/Admin/Employee/EmployeeController.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/IconStrings.dart';
import 'package:super_adminPanel/Resources/String.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({super.key});

  final controller = Get.put(EmployeeController());

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

    //  Max Width
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
              TextStrings.addEmployeeTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: scale(6, 8, 10)),
            Text(
              TextStrings.addEmployeeSubtitle,
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
                        Text(
                          TextStrings.addEmployeeContainerTitle,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: scale(14, 15, 16),
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColors,
                          ),
                        ),
                        SizedBox(height: scale(18, 20, 22)),
                        /// ShortName TextField
                        Row(
                          children: [
                            Image.asset(IconsString.personIcon,
                                width: scale(16, 18, 20),
                                height: scale(16, 18, 20)),
                            SizedBox(width: scale(6, 8, 10)),
                            Text("ShortName",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: labelFontSize)),
                          ],
                        ),
                        SizedBox(height: scale(8, 10, 12)),
                        TextFormField(
                          controller: controller.shortnameController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black, fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Enter your Short Name",
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
                        /// Name  TextField
                        SizedBox(height: scale(10, 12, 18)),
                        Row(
                          children: [
                            Image.asset(IconsString.personIcon,
                                width: scale(16, 18, 20),
                                height: scale(16, 18, 20)),
                            SizedBox(width: scale(6, 8, 10)),
                            Text("Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: labelFontSize)),
                          ],
                        ),
                        SizedBox(height: scale(8, 10, 12)),
                        TextFormField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black, fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Enter your Name",
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
                        /// Username  TextField
                        SizedBox(height: scale(10, 12, 18)),
                        Row(
                          children: [
                            Image.asset(IconsString.personIcon,
                                width: scale(16, 18, 20),
                                height: scale(16, 18, 20)),
                            SizedBox(width: scale(6, 8, 10)),
                            Text("Username",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: labelFontSize)),
                          ],
                        ),
                        SizedBox(height: scale(8, 10, 12)),
                        TextFormField(
                          controller: controller.usernameController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black, fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Enter the city Name",
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
                        /// Password  TextField
                        SizedBox(height: scale(10, 12, 18)),
                        Row(
                          children: [
                            Image.asset(IconsString.passwordIcon,
                                width: scale(16, 18, 20),
                                height: scale(16, 18, 20)),
                            SizedBox(width: scale(6, 8, 10)),
                            Text("Password",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: labelFontSize)),
                          ],
                        ),
                        SizedBox(height: scale(8, 10, 12)),
                        TextFormField(
                          controller: controller.passwordController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black, fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Set Password",
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
                        /// Confirm Password TextField
                        SizedBox(height: scale(10, 12, 18)),
                        Row(
                          children: [
                            Image.asset(IconsString.passwordIcon,
                                width: scale(16, 18, 20),
                                height: scale(16, 18, 20)),
                            SizedBox(width: scale(6, 8, 10)),
                            Text("Confirm Password",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: labelFontSize)),
                          ],
                        ),
                        SizedBox(height: scale(8, 10, 12)),
                        TextFormField(
                          controller: controller.confirmPasswordController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black, fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Re-type Password",
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
                        /// Status TextField
                        SizedBox(height: scale(10, 12, 18)),
                        Row(
                          children: [
                            Image.asset(IconsString.statusIcon,
                                width: scale(16, 18, 20),
                                height: scale(16, 18, 20)),
                            SizedBox(width: scale(6, 8, 10)),
                            Text("Status",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: labelFontSize)),
                          ],
                        ),
                        /// Status Switch
                        SizedBox(height: scale(10, 12, 18)),
                        Container(
                          height: scale(44, 46, 48),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.captionsColor, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: scale(10, 12, 14)),
                          child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                controller.isActive.value ? "Active" : "Inactive",
                                style: TextStyle(
                                  color: controller.isActive.value
                                      ? AppColors.activeTextColor
                                      : AppColors.redColor,
                                  fontSize: inputFontSize,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),


                              Container(
                                height: scale(28, 30, 32),
                                width: scale(50, 54, 58),
                                decoration: BoxDecoration(
                                  color: AppColors.dividerColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Transform.scale(
                                    scale: 0.65,
                                    child: Switch(
                                      value: controller.isActive.value,
                                      onChanged: (value) => controller.isActive.value = value,
                                      activeColor: Colors.white,
                                      inactiveThumbColor: Colors.white,
                                      activeTrackColor: AppColors.activeTextColor,
                                      inactiveTrackColor:
                                      AppColors.textColors.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
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
                            context.go('/employee');
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
