import 'package:get/get.dart';

class ProfileSettingsController extends GetxController {
  RxBool loading = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    loading(true);
    loading(false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
