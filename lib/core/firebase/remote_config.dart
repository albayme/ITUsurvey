import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:itu_geo/core/constant/constants.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

  static FirebaseRemoteConfigService? _instance; // NEW
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._(); // NEW

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await fetchAndActivate();
  }

  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: kDebugMode
              ? const Duration(seconds: 1)
              : const Duration(hours: 2),
        ),
      );
  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
        {
          RemoteConfigKey.isVerticalLayout: false,
          RemoteConfigKey.exploreBoxParams:
              '{"A1": true,"A2": true,"B1": true,"B2": true,"IELTS": false}',
          RemoteConfigKey.isPremiumOpen: false,
          RemoteConfigKey.favRestriction: 30,
          RemoteConfigKey.collectionRestriction: 5,
        },
      );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
    }
  }

  String getString(String key) => _remoteConfig.getString(key); // NEW
  bool getBool(String key) => _remoteConfig.getBool(key); // NEW
  int getInt(String key) => _remoteConfig.getInt(key); // NEW
  double getDouble(String key) => _remoteConfig.getDouble(key); // NEW

  bool get isVerticalLayout =>
      _remoteConfig.getBool(RemoteConfigKey.isVerticalLayout); // NEW

  String get exploreBoxParams =>
      _remoteConfig.getString(RemoteConfigKey.exploreBoxParams); // NEW

  bool get isPremiumOpen =>
      _remoteConfig.getBool(RemoteConfigKey.isPremiumOpen); // NEW

  int get favRestriction =>
      _remoteConfig.getInt(RemoteConfigKey.favRestriction); // NEW

  int get collectionRestriction =>
      _remoteConfig.getInt(RemoteConfigKey.collectionRestriction); // NEW
}
