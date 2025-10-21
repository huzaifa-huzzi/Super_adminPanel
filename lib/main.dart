import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:super_adminPanel/Admin/CityScreen/CityScreen.dart';
import 'package:super_adminPanel/Admin/CountryScreen/CountryScreen.dart';
import 'package:super_adminPanel/Admin/Employee/EmployeeScreen.dart';
import 'package:super_adminPanel/Admin/Keyword/AddKeyWordScreen.dart';
import 'package:super_adminPanel/Admin/Keyword/KeywordScreen.dart';
import 'package:super_adminPanel/Admin/Sidebar/Sidebar.dart';
import 'package:super_adminPanel/Admin/Sidebar/SidebarController.dart';
import 'package:super_adminPanel/Admin/StateScreen/StateScreen.dart';
import 'package:super_adminPanel/Resources/Theme.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  Get.put(Sidebarcontroller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/employee',
      routes: [

        /// SHELL
        ShellRoute(
          builder: (context, state, child) {
            return SideBarScreen(child: child);
          },
          routes: [
            GoRoute(
              path: '/employee',
              builder: (context, state) => EmployeeScreen(),
            ),
            GoRoute(
              path: '/keyword',
              builder: (context, state) => KeywordScreen(),
            ),
            GoRoute(
              path: '/country',
              builder: (context, state) => CountryScreen(),
            ),
            GoRoute(
              path: '/state',
              builder: (context, state) => StateScreen(),
            ),
            GoRoute(
              path: '/city',
              builder: (context, state) => CityScreen(),
            ),
            GoRoute(
              path: '/addKeywords',
              builder: (context, state) => AddKeywordScreen(),
            ),
          ],
        ),
      ],
    );


    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
