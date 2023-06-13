import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/hive/hive_data.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/presentation/admin_panel_screen/admin_panel_screen.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_screen.dart';
import 'package:itu_geo/presentation/teacher_panel_screen/teacher_panel_screen.dart';
import 'package:itu_geo/routes/app_routes.dart';
import 'package:itu_geo/widgets/custom_button.dart';

import 'dashboard_controller.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class DashboardScreen extends GetWidget<DashboardController> {
  List<Widget> pagesAdmin = [
    AdminPanelScreen(),
  ];
  List<Widget> pagesTeacher = [TeacherPanelScreen()];
  List<Widget> pagesStudent = [StudentPanelScreen()];
  @override
  Widget build(BuildContext context) {
    bool isTablet = isDeviceTablet();
    Widget getBody() {
      return IndexedStack(
        index: controller.tabIndex,
        children: controller.isAdmin.value
            ? pagesAdmin
            : controller.isTeacher.value
                ? pagesTeacher
                : pagesStudent,
      );
    }

    Widget getFooter() {
      List<IconData> iconItemsAdmin = [
        Icons.supervised_user_circle,
      ];

      List<IconData> iconItemsTeacher = [
        Icons.supervised_user_circle,
      ];

      List<IconData> iconItemsStudent = [
        Icons.supervised_user_circle,
      ];
      return Obx(() => AnimatedBottomNavigationBar(
          activeColor: ColorConstant.red700,
          inactiveColor: Colors.black.withOpacity(0.5),
          icons: controller.isAdmin.value
              ? iconItemsAdmin
              : controller.isTeacher.value
                  ? iconItemsTeacher
                  : iconItemsStudent,
          activeIndex: controller.tabIndex,
          notchSmoothness: NotchSmoothness.sharpEdge,
          iconSize: isTablet ? getSize(32) : getSize(30),
          height: getVerticalSize(72),
          onTap: controller.changeTabIndex));
    }

    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Obx(() => UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: Color(0xff764abc)),
                      accountName: Text(
                        controller.nameSurname.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Text(
                        controller.email.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      currentAccountPicture: const FlutterLogo(),
                    )),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  title: const Text('Setting'),
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.profileSetting);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    _logout();
                  },
                ),
                const AboutListTile(
                  // <-- SEE HERE
                  icon: Icon(
                    Icons.info,
                  ),
                  applicationIcon: Icon(
                    Icons.local_play,
                  ),
                  applicationName: 'ITU GEO',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2023',
                  aboutBoxChildren: [
                    ///Content goes here...
                  ],
                  child: Text('ITU GEO'),
                ),
              ],
            ),
          ),
          body: Obx(
            () => controller.loading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.red700,
                    ),
                  )
                : getBody(),
          ),
        );
      },
    );
  }

  _logout() {
    Get.defaultDialog(
        actions: [
          GestureDetector(
            onTap: () => {
              Get.offAllNamed(AppRoutes.signInScreen),
              HiveData().removeUserAuthData()
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                fontStyle: ButtonFontStyle.UrbanistRomanBold16,
                text: "lbl_yes".tr,
                width: getSize(75),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                fontStyle: ButtonFontStyle.UrbanistRomanBold16,
                text: "lbl_no".tr,
                width: getSize(75),
              ),
            ),
          ),
        ],
        title: "",
        middleText: "msg_logout".tr,
        backgroundColor: ColorConstant.whiteA700,
        titleStyle: TextStyle(color: ColorConstant.black900),
        middleTextStyle: TextStyle(color: ColorConstant.black900),
        radius: 30);
  }
}
