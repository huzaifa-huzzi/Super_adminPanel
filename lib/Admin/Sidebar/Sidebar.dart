import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:super_adminPanel/Admin/Sidebar/SidebarController.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/IconStrings.dart';




class SideBarScreen extends StatelessWidget {
  final Widget child;

  SideBarScreen({super.key, required this.child});

  final Sidebarcontroller controller = Get.find<Sidebarcontroller>();

  final List<Map<String, dynamic>> baseMenuItems = [
    {
      'icon': IconsString.employeeIcon,
      'label': 'Employees',
      'path': '/employee'
    },
    {
      'icon': IconsString.categoryIcon,
      'label': 'Data Filter',
      'children': [
        {
          'icon': IconsString.categoryIcon,
          'label': 'Keyword',
          'path': '/keyword'
        },
        {
          'icon': IconsString.countryIcon,
          'label': 'Country',
          'path': '/country'
        },
        {'icon': IconsString.stateIcon, 'label': 'State', 'path': '/state'},
        {'icon': IconsString.cityIcon, 'label': 'City', 'path': '/city'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get current route
    final String currentPath = GoRouter
        .of(context)
        .routerDelegate
        .currentConfiguration
        .uri
        .toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setScreenByRoute(currentPath);
    });

    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final bool isWeb = screenWidth >= 1024;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    if (isWeb) {
      return Scaffold(
        body: Column(
          children: [
            buildWebAppBar(context, screenWidth),
            Expanded(
              child: Row(
                children: [
                  buildSidebar(context, isDrawer: false),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (isTablet) {
      return Scaffold(
        appBar: buildTabletAppBar(context, screenWidth),
        body: Row(
          children: [
            buildSidebar(context, isDrawer: false),
            Expanded(child: child),
          ],
        ),
      );
    } else {
      // Mobile
      return Scaffold(
        appBar: buildMobileAppBar(context, screenWidth),
        drawer: Drawer(
          child: buildSidebar(context, isDrawer: true),
        ),
        body: child,
      );
    }
  }

  /// ---------------- Sidebar ---------------- ///
  Widget buildSidebar(BuildContext context, {bool isDrawer = false}) {
    return Obx(() {
      final bool isCollapsed = controller.isCollapsed.value;
      final double targetWidth = isCollapsed ? 110 : 160;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: targetWidth,
        color: AppColors.appBarColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: baseMenuItems.map((item) {
                  final hasChildren = item['children'] != null;
                  final bool isParentSelected =
                  controller.isParentSelected(item['label']);
                  final bool isExpanded = controller.dataFilterExpanded.value &&
                      item['label'].toString().toLowerCase() == 'data filter';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (hasChildren) {
                            controller.toggleDataFilter();
                          } else {
                            context.go(item['path']);
                            controller.setScreenByRoute(item['path']);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: isParentSelected
                                ? const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFF8F8F9),
                                Color(0xFF0085FF),
                              ],
                              stops: [0.01, 1.0],
                            )
                                : null,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                item['icon'],
                                width: 22,
                                height: 22,
                                color: isParentSelected
                                    ? AppColors.primaryColor
                                    : AppColors.textColors,
                              ),
                              if (!isCollapsed) ...[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item['label'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isParentSelected
                                          ? AppColors.primaryColor
                                          : AppColors.textColors,
                                    ),
                                  ),
                                ),
                              ],

                              if (hasChildren)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: isCollapsed ? 4 : 0,
                                  ),
                                  child: Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_right,
                                    color: AppColors.textColors,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      if (hasChildren && isExpanded && !isCollapsed)
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Column(
                            children:
                            (item['children'] as List).map<Widget>((subItem) {
                              final bool isSelected =
                                  controller.selectedPath.value ==
                                      subItem['path'];
                              return InkWell(
                                onTap: () {
                                  context.go(subItem['path']);
                                  controller.setScreenByRoute(subItem['path']);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 2),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        subItem['icon'],
                                        width: 18,
                                        height: 18,
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.textColors,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        subItem['label'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isSelected
                                              ? AppColors.primaryColor
                                              : AppColors.textColors,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }



  /// ---------------- Web AppBar ---------------- ///
  PreferredSizeWidget buildWebAppBar(BuildContext context, double screenWidth) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(73),
      child: Obx(() => Column(
        children: [
          Container(
            color: AppColors.appBarColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 52,
            child: Row(
              children: [
                /// Logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'LOGO',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.captionsColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.08),
                /// Sidebar Toggle
                GestureDetector(
                  onTap: () => controller.toggleCollapse(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfSearchBar,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.isCollapsed.value
                          ? Icons.chevron_right
                          : Icons.chevron_left,
                      color: AppColors.textColors,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.006),

                /// Screen Title
                Expanded(
                  child: Text(
                    controller.currentScreenName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),

                /// Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: screenWidth * 0.16,
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfSearchBar,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.captionsColor,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          size: 18,
                          color: AppColors.captionsColor,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.5),
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.captionsColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(width: screenWidth * 0.006),

                /// Profile Popup
                GestureDetector(
                  onTapDown: (details) async {
                    final overlay = Overlay.of(context)
                        .context
                        .findRenderObject() as RenderBox;
                    final position = RelativeRect.fromLTRB(
                      details.globalPosition.dx,
                      details.globalPosition.dy,
                      overlay.size.width - details.globalPosition.dx,
                      overlay.size.height - details.globalPosition.dy,
                    );

                    final result = await showMenu<String>(
                      context: context,
                      position: position,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      items: [
                        PopupMenuItem<String>(
                          value: "profile",
                          padding: EdgeInsets.zero,
                          child: StatefulBuilder(
                            builder: (context, setState) {


                              return InkWell(
                                onHover: (hovering) => setState(() => controller.isHovered = hovering),
                                onTap: () => Navigator.pop(context, "profile"),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  decoration: controller.isHovered
                                      ? const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFFF8F8F9),
                                        Color(0xFF0085FF),
                                      ],
                                      stops: [0.01, 1.0],
                                    ),
                                  )
                                      : const BoxDecoration(),
                                  child:  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 18,
                                        color: controller.isHovered ? AppColors.primaryColor : Colors.black,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Profile Details",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: controller.isHovered ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: "logout",
                          padding: EdgeInsets.zero,
                          child: Container(
                            color: const Color(0xFFFFE5E5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            child: Row(
                              children: [
                                const Icon(Icons.logout,
                                    size: 18, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(
                                  "Logout",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                      fontSize: 14,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );

                    if (result == "profile") {
                      context.go('/profile');
                    } else if (result == "logout") {
                      context.go('/login');
                    }
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor:AppColors.applyButtonColors ,
                        child: Center(
                            child: Center(
                              child: Text('LP',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                                color: AppColors.textColors,
                              ),),
                            )
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Lazina Pramanik",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Divider(
            height: 0.5,
            color: AppColors.captionsColor,
            thickness: 0.5,
          ),
        ],
      )),
    );
  }


  /// ---------------- Tablet AppBar ---------------- ///
  PreferredSizeWidget buildTabletAppBar(BuildContext context, double screenWidth) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 12,
        title: Row(
          children: [
            /// Logo + Chevron (Left side)
            Text(
              "LOGO",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.captionsColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: screenWidth * 0.13),
            Obx(() => GestureDetector(
              onTap: () => controller.toggleCollapse(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfSearchBar,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  controller.isCollapsed.value
                      ? Icons.chevron_right
                      : Icons.chevron_left,
                  color: AppColors.textColors,
                ),
              ),
            )),

            const Spacer(),

            Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  SizeTransition(sizeFactor: anim, axis: Axis.horizontal, child: child),
              child: controller.showSearch.value
                  ? Container(
                key: const ValueKey("searchBar"),
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfSearchBar,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.captionsColor,
                    width: 0.5,
                  ),
                ),
                alignment: Alignment.center,
                child: TextField(
                  autofocus: true,
                  cursorColor: AppColors.captionsColor,
                  style: TextStyle(fontSize: 14, color: AppColors.textColors),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 6),
                      child: Icon(Icons.search, size: 18, color: Colors.grey),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    hintText: "Search...",
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => controller.showSearch.value = false,
                    ),
                  ),
                ),
              )
                  : IconButton(
                key: const ValueKey("searchIcon"),
                icon: Icon(Icons.search, size: 22, color: AppColors.captionsColor),
                onPressed: () => controller.showSearch.value = true,
              ),
            )),

            SizedBox(width: screenWidth * 0.04),

            /// Profile Popup
            GestureDetector(
              onTapDown: (details) async {
                final overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;

                final position = RelativeRect.fromLTRB(
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                  overlay.size.width - details.globalPosition.dx,
                  overlay.size.height - details.globalPosition.dy,
                );

                final result = await showMenu<String>(
                  context: context,
                  position: position,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  items: [
                    /// Profile Details
                    PopupMenuItem<String>(
                      value: "profile",
                      padding: EdgeInsets.zero,
                      child: StatefulBuilder(
                        builder: (context, setState) {

                          return InkWell(
                            onHover: (hovering) => setState(() => controller.isHovered = hovering),
                            onTap: () => Navigator.pop(context, "profile"),
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: controller.isHovered
                                  ? const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFFF8F8F9),
                                    Color(0xFF0085FF),
                                  ],
                                  stops: [0.01, 1.0],
                                ),
                              )
                                  : const BoxDecoration(),
                              child:  Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 18,
                                    color: controller.isHovered ? AppColors.primaryColor : Colors.black,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Profile Details",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: controller.isHovered ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    /// Logout (Red background)
                    PopupMenuItem<String>(
                      value: "logout",
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        color: Color(0xFFFFE5E5),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        child: const Row(
                          children: [
                            Icon(Icons.logout, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              "Logout",
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );

                if (result == "profile") {
                  context.go('/profile');
                } else if (result == "logout") {
                  context.go('/login');
                }
              },

              /// Avatar Trigger
              child: CircleAvatar(
                radius: 16,
                backgroundColor:AppColors.applyButtonColors ,
                child: Center(
                    child: Center(
                      child: Text('LP',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 13,
                        color: AppColors.textColors,
                      ),),
                    )
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  /// ---------------- Mobile AppBar ---------------- ///
  PreferredSizeWidget buildMobileAppBar(
      BuildContext context, double screenWidth) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Obx(
            () => AppBar(
          backgroundColor: AppColors.appBarColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 12,
          title: Row(
            children: [
              /// Logo
              Text(
                "LOGO",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.captionsColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const Spacer(),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Search Toggle
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) =>
                        SizeTransition(sizeFactor: anim, axis: Axis.horizontal, child: child),
                    child: controller.showSearch.value
                        ? Builder(
                      builder: (context) {
                        final isMobile = screenWidth < 600;
                        final barWidth = isMobile ? screenWidth * 0.4 : screenWidth * 0.5;
                        final barHeight = isMobile ? 32.0 : 36.0;
                        final iconSize = isMobile ? 16.0 : 20.0;
                        final fontSize = isMobile ? 12.0 : 14.0;

                        return Container(
                          key: const ValueKey("searchBar"),
                          width: barWidth,
                          height: barHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundOfSearchBar,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.captionsColor,
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, size: iconSize, color: Colors.grey),
                              const SizedBox(width: 6),
                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  cursorColor: AppColors.captionsColor,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppColors.textColors,
                                  ),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    hintText: "Search...",
                                    hintStyle: TextStyle(fontSize: fontSize, color: Colors.grey),
                                  ),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(Icons.close, size: iconSize, color: Colors.grey),
                                onPressed: () => controller.showSearch.value = false,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                        : IconButton(
                      key: const ValueKey("searchIcon"),
                      icon: Icon(
                        Icons.search,
                        size: 22,
                        color: AppColors.captionsColor,
                      ),
                      onPressed: () => controller.showSearch.value = true,
                    ),
                  ),


                  SizedBox(width: screenWidth * 0.02),

                  /// Drawer Menu Icon
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfSearchBar,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            IconsString.menuIcon,
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



}
