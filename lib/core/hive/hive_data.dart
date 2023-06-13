import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/models/user_model.dart';

class HiveData {
  Future<void> initialize() async {
    await _openBoxes();
  }

  Future<void> _openBoxes() async {
    await Hive.openBox(HiveKey.accountData);
  }

  setUserAuthData(UserData data) {
    final box = Hive.box(HiveKey.accountData);
    box.put(HiveKey.userEmail, data.email);
    box.put(HiveKey.name, data.name);
    box.put(HiveKey.surname, data.surname);
    box.put(HiveKey.isActive, data.isActive);
    box.put(HiveKey.isPending, data.isPending);
    box.put(HiveKey.isTeacher, data.isTeacher);
    box.put(HiveKey.isAdmin, data.isAdmin);
  }

  removeUserAuthData() {
    final box = Hive.box(HiveKey.accountData);
    box.delete(HiveKey.userEmail);
    box.delete(HiveKey.name);
    box.delete(HiveKey.surname);
    box.delete(HiveKey.isActive);
    box.delete(HiveKey.isPending);
    box.delete(HiveKey.isTeacher);
    box.delete(HiveKey.isAdmin);
  }
}
