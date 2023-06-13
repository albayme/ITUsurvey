import 'package:get/get.dart';
import 'package:itu_geo/presentation/add_activity_screen/add_activity_binding.dart';
import 'package:itu_geo/presentation/add_activity_screen/add_activity_screen.dart';
import 'package:itu_geo/presentation/add_announcement_screen/add_announcement_binding.dart';
import 'package:itu_geo/presentation/add_announcement_screen/add_announcement_screen.dart';
import 'package:itu_geo/presentation/add_course_screen/add_course_binding.dart';
import 'package:itu_geo/presentation/add_course_screen/add_course_screen.dart';
import 'package:itu_geo/presentation/announcement_detail_screen/announcement_detail_binding.dart';
import 'package:itu_geo/presentation/announcement_detail_screen/announcement_detail_screen.dart';
import 'package:itu_geo/presentation/announcement_list_screen/announcement_list_binding.dart';
import 'package:itu_geo/presentation/announcement_list_screen/announcement_list_screen.dart';
import 'package:itu_geo/presentation/attachement_list_screen/attachement_list_binding.dart';
import 'package:itu_geo/presentation/attachement_list_screen/attachement_list_screen.dart';
import 'package:itu_geo/presentation/course_create_success_screen/course_create_success_binding.dart';
import 'package:itu_geo/presentation/course_create_success_screen/course_create_success_screen.dart';
import 'package:itu_geo/presentation/dashboard_screen/dashboard_binding.dart';
import 'package:itu_geo/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:itu_geo/presentation/map_view_screen/map_view_binding.dart';
import 'package:itu_geo/presentation/map_view_screen/map_view_screen.dart';
import 'package:itu_geo/presentation/profile_settings_screen/binding/profile_settings_binding.dart';
import 'package:itu_geo/presentation/profile_settings_screen/profile_settings_screen.dart';
import 'package:itu_geo/presentation/sign_in_screen/binding/sign_in_binding.dart';
import 'package:itu_geo/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:itu_geo/presentation/sign_up_screen/binding/sign_up_binding.dart';
import 'package:itu_geo/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:itu_geo/presentation/splash_screen/binding/splash_binding.dart';
import 'package:itu_geo/presentation/splash_screen/splash_screen.dart';
import 'package:itu_geo/presentation/view_activity_screen/view_activity_binding.dart';
import 'package:itu_geo/presentation/view_activity_screen/view_activity_screen.dart';
import 'package:itu_geo/presentation/waiting_students_screen/waiting_students_binding.dart';
import 'package:itu_geo/presentation/waiting_students_screen/waiting_students_screen.dart';

class AppRoutes {
  static String splashScreen = '/splash_screen';

  static String signInScreen = '/sign_in_screen';

  static String dashboardScreen = '/dashboard_screen';

  static String signUpScreen = '/sign_up_screen';

  static String homeScreen = '/home_screen';

  static String waitingStudentsScreen = '/waiting_students_screen';

  static String initialRoute = '/initialRoute';

  static String profileSetting = '/profile_settings';

  static String testScreen = '/test_screen';

  static String addCourseScreen = '/add_course_screen';

  static String addAnnouncementScreen = '/add_announcement_screen';
  static String listAnnouncementScreen = '/list_announcement_screen';
  static String detailAnnouncementScreen = '/detail_announcement_screen';

  static String listAttachementScreen = '/list_attachment_screen';

  static String createCourseSuccessScreen = '/create_course_success_screen';

  static String mapViewScreen = '/map_view_screen';

  static String addActivityScreen = '/add_activity_screen';

  static String viewActivityScreen = '/view_activity_screen';

  static List<GetPage> pages = [
    GetPage(
      name: viewActivityScreen,
      page: () => ViewActivityScreen(),
      bindings: [
        ViewActivityBinding(),
      ],
    ),
    GetPage(
      name: addActivityScreen,
      page: () => AddActivityScreen(),
      bindings: [
        AddActivityBinding(),
      ],
    ),
    GetPage(
      name: mapViewScreen,
      page: () => MapViewScreen(),
      bindings: [
        MapViewBinding(),
      ],
    ),
    GetPage(
      name: listAttachementScreen,
      page: () => AttachementListScreen(),
      bindings: [
        AttachementListBinding(),
      ],
    ),
    GetPage(
      name: detailAnnouncementScreen,
      page: () => AnnouncementDetailScreen(),
      bindings: [
        AnnouncementDetailBinding(),
      ],
    ),
    GetPage(
      name: addAnnouncementScreen,
      page: () => AddAnnouncementScreen(),
      bindings: [
        AddAnnouncementBinding(),
      ],
    ),
    GetPage(
      name: listAnnouncementScreen,
      page: () => AnnouncementListScreen(),
      bindings: [
        AnnouncementListBinding(),
      ],
    ),
    GetPage(
      name: createCourseSuccessScreen,
      page: () => CourseCreateSuccessScreen(),
      bindings: [
        CourseCreateSuccessBinding(),
      ],
    ),
    GetPage(
      name: profileSetting,
      page: () => ProfileSettingsScreen(),
      bindings: [
        ProfileSettingsBinding(),
      ],
    ),
    GetPage(
      name: waitingStudentsScreen,
      page: () => WaitingStudentScreen(),
      bindings: [
        WaitingStudentBinding(),
      ],
    ),
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: signInScreen,
      page: () => SignInScreen(),
      bindings: [
        SignInBinding(),
      ],
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
    GetPage(
      name: dashboardScreen,
      page: () => DashboardScreen(),
      bindings: [
        DashboardBinding(),
      ],
    ),
    GetPage(
      name: addCourseScreen,
      page: () => AddCourseScreen(),
      bindings: [
        AddCourseBinding(),
      ],
    ),
  ];
}
