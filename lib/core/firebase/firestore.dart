// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:itu_geo/core/network/network_info.dart';
import 'package:itu_geo/models/announcement_model.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';

class FireStore {
  FireStore._()
      : _db = FirebaseFirestore.instance,
        _network = Get.find<NetworkInfo>();

  static FireStore? _instance; // NEW
  factory FireStore() => _instance ??= FireStore._(); // NEW

  final FirebaseFirestore _db;
  final NetworkInfo _network;
  Future<void> initialize() async {
    await _setConfigSettings();
  }

  Future<void> _setConfigSettings() async => _db.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
  FirebaseFirestore getDB() => _db; // NEW

  Future<void> createUser(UserData data) async {
    if (await _network.isConnected()) {
      String id = data.id;
      final bulkData = <String, dynamic>{
        "userId": data.id,
        "name": data.name,
        "email": data.email,
        "surname": data.surname,
        "courseID": data.courseID,
        "isTeacher": data.isTeacher,
        "isAdmin": data.isAdmin,
        "isActive": data.isActive,
        "isPending": data.isPending,
        "created": Timestamp.now(),
        "updated": Timestamp.now(),
      };
      await _db.collection("users").doc(id).set(bulkData);
    }
  }

  Future<void> createAnnouncement(AnnouncementData data) async {
    if (await _network.isConnected()) {
      final bulkData = <String, dynamic>{
        "description": data.description,
        "courseID": data.courseID,
        "documentRef": data.documentRef,
        "isActive": data.isActive,
        "created": Timestamp.now(),
        "updated": Timestamp.now(),
      };
      await _db.collection("announcements").doc().set(bulkData);
    }
  }

  Future<void> sendAnnouncementComment(AnnouncementComment data) async {
    if (await _network.isConnected()) {
      final bulkData = <String, dynamic>{
        "announcementID": data.announcementID,
        "comment": data.comment,
        "senderID": data.senderID,
        "senderName": data.senderName,
        "created": Timestamp.now(),
        "updated": Timestamp.now(),
      };
      await _db.collection("comments").doc().set(bulkData);
    }
  }

  Future<List<AnnouncementData>> getAnnoucementsByCourseID(String id) async {
    List<AnnouncementData> result = [];
    if (await _network.isConnected()) {
      final docRef = _db.collection("announcements");
      var data = await docRef
          .where("courseID", isEqualTo: id)
          .orderBy("updated", descending: true)
          .get();

      if (data.docs.isNotEmpty) {
        for (var i = 0; i < data.docs.length; i++) {
          final userData =
              mapAnnouncementData(data.docs[i].id, data.docs[i].data());
          result.add(userData);
        }
      }
    }
    return result;
  }

  Future<List<StudentData>> getStudentDataByCourseID(String id) async {
    List<StudentData> result = [];
    if (await _network.isConnected()) {
      final docRef = _db.collection("activities");
      var data = await docRef
          .where("courseId", isEqualTo: id)
          .orderBy("updated", descending: true)
          .get();

      if (data.docs.isNotEmpty) {
        for (var i = 0; i < data.docs.length; i++) {
          final userData = mapStudentData(data.docs[i].data(),data.docs[i].id);
          result.add(userData);
        }
      }
    }
    return result;
  }

  Future<void> removeAccount() async {
    if (await _network.isConnected()) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      var user = auth.currentUser;
      if (user != null) {
        await user.delete();
      }
    }
  }

  Future<void> createCourse(CourseData data) async {
    if (await _network.isConnected()) {
      final bulkData = <String, dynamic>{
        "courseId": data.id,
        "name": data.name,
        "code": data.code,
        "teacherId": data.teacherId,
        "lessonCode": data.lessonCode,
        "isActive": data.isActive,
        "pinDetail": data.pinDetail,
        "coordinates": data.coordinates,
        "created": Timestamp.now(),
        "updated": Timestamp.now(),
        "documentRef": data.documentRef,
        "students": [],
        "waitingStudents": []
      };
      await _db.collection("courses").doc().set(bulkData);
    }
  }

  Future<void> createActivitiy(StudentData data) async {
    if (await _network.isConnected()) {
      final bulkData = <String, dynamic>{
        "courseId": data.courseID,
        "name": data.name,
        "surname": data.surname,
        "coordinates": data.coordinates,
        "email": data.email,
        "specialNames": data.specialNames,
        "studentActivity": data.studentActivity,
        "id": data.id,
        "documentRef": data.documentRef,
        "created": Timestamp.now(),
        "updated": Timestamp.now(),
      };
      await _db.collection("activities").doc().set(bulkData);
    }
  }
  Future<void> deleteActivity(String id) async {
    if (await _network.isConnected()) {
      await _db.collection("activities").doc(id).delete();
    }
  }

  Future<void> updateCourse(String id, CourseData data) async {
    if (await _network.isConnected()) {
      final courseRef = _db.collection("courses").doc(id);
      courseRef.update({
        "courseId": id,
        "name": data.name,
        "code": data.code,
        "teacherId": data.teacherId,
        "lessonCode": data.lessonCode,
        "isActive": data.isActive,
        "coordinates": data.coordinates,
        "updated": Timestamp.now(),
        "documentRef": data.documentRef,
        "students": data.students,
        "waitingStudents": data.waitingStudents
      }).then((value) => print("DocumentSnapshot successfully updated!"),
          onError: (e) => print("Error updating document $e"));
    }
  }

  Future<List<AnnouncementComment>> getCommentsByAnnouncementID(
      String id) async {
    List<AnnouncementComment> result = [];
    if (await _network.isConnected()) {
      final docRef = _db.collection("comments");
      var data = await docRef
          .where("announcementID", isEqualTo: id)
          .orderBy("created", descending: true)
          .get();

      if (data.docs.isNotEmpty) {
        for (var i = 0; i < data.docs.length; i++) {
          final userData = mapAnnouncementComment(data.docs[i].data());
          result.add(userData);
        }
      }
    }
    return result;
  }

  Future<List<UserData>> getUsers() async {
    List<UserData> result = [];
    if (await _network.isConnected()) {
      final docRef = _db.collection("users");
      var data = await docRef.get();

      if (data.docs.isNotEmpty) {
        for (var i = 0; i < data.docs.length; i++) {
          final userData = mapUserData(data.docs[i].data());
          result.add(userData);
        }
      }
    }
    return result;
  }

  Future<List<CourseData>> getCourses() async {
    List<CourseData> result = [];
    if (await _network.isConnected()) {
      final docRef = _db.collection("courses");
      var data = await docRef.get();

      if (data.docs.isNotEmpty) {
        for (var i = 0; i < data.docs.length; i++) {
          final userData = mapCourseData(data.docs[i].id, data.docs[i].data());
          result.add(userData);
        }
      }
    }
    return result;
  }

  Future<List<CourseData>> getCoursesData(String teacherId) async {
    List<CourseData> result = [];
    if (await _network.isConnected()) {
      final docRef = _db.collection("courses");
      var data = await docRef.where("teacherId", isEqualTo: teacherId).get();

      if (data.docs.isNotEmpty) {
        for (var i = 0; i < data.docs.length; i++) {
          final courseData =
              mapCourseData(data.docs[i].id, data.docs[i].data());
          result.add(courseData);
        }
      }
    }
    return result;
  }

  Future<List<CourseData>> getCourseDataByInviteCode(String code) async {
    List<CourseData> result = [];
    if (await _network.isConnected()) {
      final docRef = _db.collection("courses");
      var data = await docRef.where("code", isEqualTo: code).get();

      if (data.docs.isNotEmpty) {
        for (var i = 0; i < data.docs.length; i++) {
          final courseData =
              mapCourseData(data.docs[i].id, data.docs[i].data());
          result.add(courseData);
        }
      }
    }
    return result;
  }

  Future<UserData> getUserByEmail(String email) async {
    UserData result = initialUserData;
    if (await _network.isConnected()) {
      final docRef = _db.collection("users");
      var data = await docRef.where("email", isEqualTo: email).get();

      if (data.docs.isNotEmpty) {
        result = mapUserData(data.docs[0].data());
      }
    }
    return result;
  }

  Future<UserData> getUserById(String id) async {
    UserData result = initialUserData;
    if (await _network.isConnected()) {
      final docRef = _db.collection("users").doc(id);
      var data = await docRef.get();

      if (data.exists) {
        result = mapUserData(data.data() ?? {});
      }
    }
    return result;
  }

  Future<CourseData> getCourseDataById(String id) async {
    CourseData result = initialCourseData;
    if (await _network.isConnected()) {
      final docRef = _db.collection("courses").doc(id);
      var data = await docRef.get();

      if (data.exists) {
        result = mapCourseData(id, data.data() ?? {});
      }
    }
    return result;
  }

  AnnouncementData mapAnnouncementData(String id, Map<String, dynamic> doc) {
    final data = AnnouncementData(
        id ?? "",
        doc['description'] ?? "",
        doc['courseID'] ?? "",
        doc['isActive'] ?? false,
        doc['documentRef'] ?? [],
        doc['created'] ?? Timestamp.now(),
        doc['uptaded'] ?? Timestamp.now());
    return data;
  }

  AnnouncementComment mapAnnouncementComment(Map<String, dynamic> doc) {
    final data = AnnouncementComment(
      doc['announcementID'] ?? "",
      doc['comment'] ?? "",
      doc['senderID'] ?? "",
      doc['senderName'] ?? "",
      doc['created'] ?? Timestamp.now(),
      doc['updated'] ?? Timestamp.now(),
    );
    return data;
  }

  UserData mapUserData(Map<String, dynamic> doc) {
    final data = UserData(
      doc['userId'] ?? "",
      doc['email'] ?? "",
      doc['name'] ?? "",
      doc['surname'] ?? "",
      doc['courseID'] ?? "",
      doc['isAdmin'] ?? false,
      doc['isTeacher'] ?? false,
      doc['isActive'] ?? false,
      doc['isPending'] ?? true,
    );
    return data;
  }

  StudentData mapStudentData(Map<String, dynamic> doc,String id) {
    final data = StudentData(
        id ?? "",
        doc['email'] ?? "",
        doc['name'] ?? "",
        doc['surname'] ?? "",
        doc['courseId'] ?? "",
        doc['coordinates'] ?? [],
        doc['specialNames'] ?? [],
        doc['studentActivity'] ?? [],
        doc['documentRef'] ?? [],
        doc['created'] ?? Timestamp.now(),
        doc['uptaded'] ?? Timestamp.now());
    return data;
  }

  CourseData mapCourseData(String id, Map<String, dynamic> doc) {
    final data = CourseData(
        id,
        doc['name'] ?? "",
        doc['description'] ?? "",
        doc['lessonCode'] ?? "",
        doc['code'] ?? "",
        doc['teacherId'] ?? "",
        doc['isActive'] ?? false,
        doc['coordinates'] ?? [],
        doc['pinDetail'] ?? {},
        doc['documentRef'] ?? [],
        doc['students'] ?? [],
        doc['waitingStudents'] ?? []);
    return data;
  }

  Future<void> updateUserData(UserData data) async {
    if (await _network.isConnected()) {
      final bulkData = <String, dynamic>{
        "email": data.email,
        "name": data.name,
        "surname": data.surname,
        "courseID": data.courseID,
        "isAdmin": data.isAdmin,
        "isPending": data.isPending,
        "isTeacher": data.isTeacher,
        "isActive": data.isActive,
        "updatedTime": Timestamp.now(),
      };
      await _db.collection("users").doc(data.id).update(bulkData);
    }
  }
}
