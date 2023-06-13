import 'package:cloud_firestore/cloud_firestore.dart';

class CourseData {
  String id;
  String name;
  String description;
  String lessonCode;
  String code;
  String teacherId;
  bool isActive;
  List coordinates;
  Map<String, dynamic> pinDetail;
  List documentRef;
  List students;
  List waitingStudents;
  CourseData(
      this.id,
      this.name,
      this.description,
      this.lessonCode,
      this.code,
      this.teacherId,
      this.isActive,
      this.coordinates,
      this.pinDetail,
      this.documentRef,
      this.students,
      this.waitingStudents);
}

CourseData get initialCourseData => CourseData(
    "", "", "", "", "", "", false, const [GeoPoint(0.0, 0.0)], {}, [], [], []);
