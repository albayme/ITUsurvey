import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/presentation/admin_panel_screen/admin_panel_controller.dart';
import 'package:itu_geo/presentation/admin_panel_screen/widget/list_courses_data.dart';
import 'package:itu_geo/presentation/admin_panel_screen/widget/list_favorite_worddata.dart';
import 'package:itu_geo/widgets/custom_button.dart';

class AdminPanelScreen extends GetWidget<AdminPanelController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leadingWidth: 50,
            leading: InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: getPadding(left: 8, right: 8),
                  child: const Icon(
                    Icons.menu_open,
                    color: Colors.black,
                  ),
                )),
            titleTextStyle: const TextStyle(
                color: Colors.black,
                fontFamily: "urbanist",
                fontSize: 24,
                fontWeight: FontWeight.w600),
            bottom: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "User",
                ),
                Tab(
                  text: "Course",
                ),
              ],
            ), // TabBar
            title: const Center(child: Text('Admin Panel')),
            backgroundColor: Colors.white,
          ),
          backgroundColor: ColorConstant.whiteA700,
          body: Obx(() => controller.showLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.red,
                ))
              : TabBarView(
                  children: [
                    _buildListAllUser(),
                    _buildListAllCourse() ?? Container()
                  ],
                ))),
    ));
  }

  _buildPendingUserWidget() {
    return Padding(
      padding: getPadding(top: 12
          // right: 10,
          ),
      child: RefreshIndicator(
        onRefresh: () => controller.refleshData(),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            UserData model = controller.data.value[index];
            return ListUserDataWidget(model, () async => {await controller.refleshData()});
          },
        ),
      ),
    );
  }

  _buildListAllUser() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () => controller.applyFilter("all"),
                  width: 80,
                  text: "All",
                  shape: ButtonShape.BuyButtonCircle,
                ),
                CustomButton(
                  onTap: () => controller.applyFilter("pending"),
                  width: 80,
                  text: "Pending",
                  shape: ButtonShape.BuyButtonCircle,
                ),
                CustomButton(
                  onTap: () => controller.applyFilter("teacher"),
                  width: 80,
                  text: "Tutor",
                  shape: ButtonShape.BuyButtonCircle,
                ),
                CustomButton(
                  onTap: () => controller.applyFilter("student"),
                  width: 80,
                  text: "Student",
                  shape: ButtonShape.BuyButtonCircle,
                ),
              ],
            ),
          ),
          _buildPendingUserWidget()
        ],
      ),
    );
  }

  _buildListAllCourse() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_buildCoursesWidget()],
      ),
    );
  }

  _buildCoursesWidget() {
    return Padding(
      padding: getPadding(
        top: 12,
        // right: 10,
      ),
      child: RefreshIndicator(
        onRefresh: () => controller.refleshData(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: controller.courseData.length,
          itemBuilder: (context, index) {
            CourseData model = controller.courseData.value[index];
            return ListCourseDataWidget(
              model,
            );
          },
        ),
      ),
    );
  }
}
