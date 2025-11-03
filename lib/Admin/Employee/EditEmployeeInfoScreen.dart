import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/IconStrings.dart';
import 'package:super_adminPanel/Resources/String.dart';
import 'EmployeeController.dart';

class EditEmployeeInfoScreen extends StatelessWidget {
  EditEmployeeInfoScreen({super.key});

  final controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1000;

    double scaleFor(double mobile, double tablet, double desktop) {
      if (isMobile) return mobile;
      if (isTablet) return tablet;
      return desktop;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? scaleFor(10, 20, 40) : scaleFor(20, 40, 60),
        vertical: scaleFor(10, 15, 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///  HEADER
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextStrings.editEmployeeTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: scaleFor(15, 17, 19),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: scaleFor(4, 4, 3)),
              Text(
                TextStrings.editEmployeeSubtitle,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: scaleFor(11, 12, 13),
                ),
              ),
            ],
          ),

          SizedBox(height: scaleFor(14, 18, 20)),

          ///  Edit Employee CONTAINER
          Align(
            alignment: isMobile ? Alignment.center : Alignment.topLeft,
            child: Container(
              alignment: Alignment.centerLeft,
              width: isMobile ? width * 0.95 : (isTablet ? width * 0.7 : width * 0.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(scaleFor(10, 12, 14)),
              ),
              padding: EdgeInsets.all(scaleFor(14, 18, 20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    TextStrings.editEmployeeContainerTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: scaleFor(15, 17, 19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: scaleFor(16, 18, 20)),

                  /// ---- Short Name ----
                  _buildRow(
                    context,
                    isMobile,
                    isTablet,
                    icon: IconsString.nameIcon,
                    label: "Short Name",
                    value: "LP",
                    onTap: () {},
                    scaleFor: scaleFor,
                  ),
                  Divider(color: AppColors.dividerColor),

                  /// ---- Name ----
                  _buildRow(
                    context,
                    isMobile,
                    isTablet,
                    icon: IconsString.nameIcon,
                    label: "Name",
                    value: "Mst. Lazina Khatun",
                    onTap: () {},
                    scaleFor: scaleFor,
                  ),

                  /// ---- User Name ----
                  _buildRow(
                    context,
                    isMobile,
                    isTablet,
                    icon: IconsString.nameIcon,
                    label: "User Name",
                    value: "Lazina Pramanik",
                    onTap: () {},
                    scaleFor: scaleFor,
                  ),
                  Divider(color: AppColors.dividerColor),

                  /// ---- Password ----
                  _buildRow(
                    context,
                    isMobile,
                    isTablet,
                    icon: IconsString.passwordIcon,
                    label: "Password",
                    value: "•••••",
                    onTap: () {},
                    scaleFor: scaleFor,
                    isPassword: true,
                  ),

                  /// ---- Status ----
                  Obx(() {
                    return _buildRow(
                      context,
                      isMobile,
                      isTablet,
                      icon: IconsString.statusIcon,
                      label: "Status",
                      value: controller.isActive.value ? "Active" : "Inactive",
                      onTap: () {},
                      scaleFor: scaleFor,
                      isStatus: true,
                      isSwitchOn: controller.isActive.value,
                      onToggle: (val) {
                        controller.isActive.value = val;
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  /// -------------- Extra Widgets ------------- ///
  /// Main Row Builder

  Widget _buildRow(
      BuildContext context,
      bool isMobile,
      bool isTablet, {
        required String icon,
        required String label,
        required String value,
        required VoidCallback onTap,
        required double Function(double, double, double) scaleFor,
        bool isPassword = false,
        bool isStatus = false,
        bool isSwitchOn = false,
        ValueChanged<bool>? onToggle,
      }) {
    final fontSize = scaleFor(13, 14, 15);
    final valueSize = scaleFor(13, 14, 15);
    final gap = scaleFor(6, 8, 10);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleFor(6, 8, 10)),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           /// Mobile and Tablets
          Row(
            children: [
              /// Left Icon Box
              Container(
                height: scaleFor(42, 46, 50),
                width: scaleFor(42, 46, 50),
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Image.asset(
                    icon,
                    height: scaleFor(22, 24, 26),
                    width: scaleFor(22, 24, 26),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: AppColors.captionsColor,
                  ),
                ),
              ),

              /// Edit Button Box (Right)
              if (!isStatus)
                InkWell(
                  onTap: onTap,
                  child: Container(
                    height: scaleFor(24, 26, 28),
                    width: scaleFor(24, 26, 28),
                    decoration: BoxDecoration(
                      color: AppColors.dividerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        IconsString.editIcon,
                        width: scaleFor(16, 18, 20),
                        height: scaleFor(16, 18, 20),
                        color: AppColors.textColors.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: scaleFor(4, 5, 6)),
           /// For web
          isStatus
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: isSwitchOn
                      ? AppColors.activeTextColor
                      : AppColors.redColor,
                  fontSize: valueSize,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// Switch Box
              Container(
                height: scaleFor(36, 38, 40),
                width: scaleFor(60, 65, 70),
                padding: EdgeInsets.symmetric(
                    horizontal: scaleFor(4, 6, 8)),
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isSwitchOn,
                      onChanged: onToggle,
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.white,
                      activeTrackColor: AppColors.activeTextColor,
                    ),
                  ),
                ),
              ),
            ],
          )
              : Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: FontWeight.w600,
              color: AppColors.textColors,
            ),
          ),
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Left Icon Box
          Container(
            height: scaleFor(24, 26, 28),
            width: scaleFor(24, 26, 28),
            decoration: BoxDecoration(
              color: AppColors.dividerColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                icon,
                height: scaleFor(16, 18, 20),
                width: scaleFor(16, 18, 20),
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(width: gap),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.captionsColor,
            ),
          ),
          const Spacer(),

          /// Right Section
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: valueSize,
                  fontWeight: FontWeight.w600,
                  color: isStatus
                      ? (isSwitchOn
                      ? AppColors.activeTextColor
                      : AppColors.redColor)
                      : AppColors.textColors,
                ),
              ),
              SizedBox(width: scaleFor(6, 8, 10)),

              /// Switch or Edit Box
              isStatus
                  ? Container(
                height: scaleFor(28, 30, 32),
                width: scaleFor(50, 54, 58),
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Transform.scale(
                    scale: 0.65,
                    child: Switch(
                      value: isSwitchOn,
                      onChanged: onToggle,
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.white,
                      activeTrackColor: AppColors.activeTextColor,
                      inactiveTrackColor: AppColors.textColors.withOpacity(0.2),
                    ),
                  ),
                ),
              )
                  : InkWell(
                onTap: onTap,
                child: Container(
                  height: scaleFor(28, 30, 32),
                  width: scaleFor(28, 30, 32),
                  decoration: BoxDecoration(
                    color: AppColors.dividerColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(
                      IconsString.editIcon,
                      width: scaleFor(16, 18, 20),
                      height: scaleFor(16, 18, 20),
                      color: AppColors.textColors.withOpacity(0.7),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }


}
