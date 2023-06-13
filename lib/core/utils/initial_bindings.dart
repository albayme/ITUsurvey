import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart' as h;
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/firebase/remote_config.dart';
import 'package:itu_geo/core/hive/hive_data.dart';
import 'package:itu_geo/core/network/network_info.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    await FireStore().initialize();
    await h.Hive.initFlutter();
    await HiveData().initialize();
    await FirebaseRemoteConfigService().initialize();
    await FlutterDownloader.initialize(
        debug:
            false, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
  }
}
