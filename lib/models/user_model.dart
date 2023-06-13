import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String email;
  String name;
  String surname;
  String courseID;
  bool isAdmin;
  bool isTeacher;
  bool isActive;
  bool isPending;
  UserData(
    this.id,
    this.email,
    this.name,
    this.surname,
    this.courseID,
    this.isAdmin,
    this.isTeacher,
    this.isActive,
    this.isPending,
  );
}

class StudentData {
  String id;
  String email;
  String name;
  String surname;
  String courseID;
  List coordinates;
  List specialNames;
  List studentActivity;
  List documentRef;
  Timestamp created;
  Timestamp updated;
  StudentData(
      this.id,
      this.email,
      this.name,
      this.surname,
      this.courseID,
      this.coordinates,
      this.specialNames,
      this.studentActivity,
      this.documentRef,
      this.created,
      this.updated);
}

class ItemModel {
  bool expanded;
  String headerItem;
  String discription;

  ItemModel({
    this.expanded = false,
    required this.headerItem,
    required this.discription,
  });
}

StudentData get initialStudenData => StudentData(
    "", "", "", "", "", [], [], [], [], Timestamp.now(), Timestamp.now());

UserData get initialUserData =>
    UserData("", "", "", "", "", false, false, false, false);
