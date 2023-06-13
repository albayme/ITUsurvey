import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementData {
  String id;
  String description;
  String courseID;
  bool isActive;
  List documentRef;
  Timestamp created;
  Timestamp updated;
  AnnouncementData(this.id, this.description, this.courseID, this.isActive,
      this.documentRef, this.created, this.updated);
}

class AnnouncementComment {
  String announcementID;
  String comment;
  String senderID;
  String senderName;
  Timestamp created;
  Timestamp updated;
  AnnouncementComment(this.announcementID, this.comment, this.senderID,
      this.senderName, this.created, this.updated);
}

AnnouncementComment get initialAnnouncementComment =>
    AnnouncementComment("", "", "", "", Timestamp.now(), Timestamp.now());

AnnouncementData get initialAnnouncementData =>
    AnnouncementData("", "", "", false, [], Timestamp.now(), Timestamp.now());
