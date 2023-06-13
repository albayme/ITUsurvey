import 'package:get/get.dart';
import 'package:itu_geo/presentation/announcement_detail_screen/announcement_detail_controller.dart';
import 'package:itu_geo/presentation/announcement_list_screen/announcement_list_controller.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';

class AnnouncementDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementDetailController());
    Get.lazyPut(() => AnnouncementListController());
  }
}
