import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:itu_geo/core/constant/constants.dart';
import 'package:itu_geo/core/firebase/firestore.dart';
import 'package:itu_geo/core/utils/progress_dialog_utils.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/presentation/student_panel_screem/studen_panel_controller.dart';
import 'package:itu_geo/routes/app_routes.dart';

class AddActivityController extends GetxController {
  RxInt activeCurrentStep = 0.obs;
  RxInt numberOfTeacherPin = 0.obs;
  RxInt numberOfCurrenctPin = 0.obs;
  RxList<TextEditingController> pinDetailsController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> studentNoteOnPinsController =
      <TextEditingController>[].obs;
  RxBool showMessageArea = false.obs;
  RxList attachments = [].obs;
  RxList<ItemModel> itemData = <ItemModel>[].obs;

  TextEditingController courseNameController = TextEditingController();
  Rx<String> courseNameErrorMessage = "".obs;
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController pinDescriptionController = TextEditingController();

  TextEditingController courseCodeController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  RxInt markerIdCounter = 1.obs;
  RxBool toggle = false.obs;
  RxBool toggleExpansion = false.obs;

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  RxList<double> currentPosition = [37.42796133580664, -122.085749655962].obs;
  RxList position = [].obs;
  Rx<CourseData> courseData = initialCourseData.obs;
  RxBool showMap = false.obs;
  RxBool isEditMode = false.obs;

  StudentPanelController studentPanelController =
      Get.find<StudentPanelController>();

  late final Completer<GoogleMapController> mapC;
  late final GoogleMapController c;
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Rx<String> courseCodeErrorMessage = "".obs;
  final box = Hive.box(HiveKey.accountData);



  validate() {
    bool flag = false;
    for (var i = 0; i < studentNoteOnPinsController.length; i++) {
      if (studentNoteOnPinsController.value[i].text.toString() != "") {
        flag = true;
      }
    }
    if (attachments.value.isNotEmpty || flag) {
      return true;
    } else {
      Get.snackbar("Needs to activity",
          "Please add attachement or activity on any pins");
      return false;
    }
  }

  Future<void> save() async {
    if (validate()) {
      ProgressDialogUtils.showProgressDialog();

      var email = box.get(HiveKey.userEmail) ?? "";
      var name = box.get(HiveKey.name) ?? "";
      var surname = box.get(HiveKey.surname) ?? "";
      var documentRef = await uploadAttachements();

      StudentData data = initialStudenData;
      data.courseID = courseData.value.id;
      data.email = email;
      data.name = name;
      data.surname = surname;
      var special = [];
      var studentAct = [];
      List<GeoPoint> l = [];

      for (var i = 0; i < studentNoteOnPinsController.length; i++) {
        if (pinDetailsController.value[i].text.toString() != "") {
          special.add(pinDetailsController.value[i].text.toString());
          studentAct.add(studentNoteOnPinsController.value[i].text.toString());
          var g = GeoPoint(position[i][0], position[i][1]);
          l.add(g);
        }
      }
      data.coordinates = l;
      data.specialNames = special;
      data.studentActivity = studentAct;
      data.documentRef = documentRef;

      await FireStore().createActivitiy(data);
      await studentPanelController.updateStudentActivity();
      ProgressDialogUtils.hideProgressDialog();
      Get.back();
    }
  }

  @override
  void onClose() {
    // for (var i = 0; i < studentNoteOnPinsController.length; i++) {
    //   studentNoteOnPinsController[i].dispose();
    // }
    // for (var i = 0; i < pinDetailsController.length; i++) {
    //   pinDetailsController[i].dispose();
    // }
    // courseNameController.dispose();
    // courseCodeController.dispose();
    // courseDescriptionController.dispose();
    // latController.dispose();
    // pinCodeController.dispose();
    // pinDescriptionController.dispose();
    // longController.dispose();
    // c.dispose();
    // studentPanelController.dispose();
    super.onClose();

  }

  @override
  Future<void> onInit() async {
    super.onInit();
    courseData.value = await Get.arguments[0];
    isEditMode.value = await Get.arguments[1];
    await setMarkers();
    updatePosition();
    showMap.value = true;
    mapC =  Completer<GoogleMapController>();
    c = await mapC.future;
  }

  updatePosition() {
    var l = [];
    markers.value.forEach((key, value) {
      l.add([value.position.latitude, value.position.longitude]);
    });
    position.value = l;
  }

  updateStep2() {
    if (numberOfCurrenctPin.value != pinDetailsController.length) {
      studentNoteOnPinsController.value = [];
      pinDetailsController.value = [];
      for (var i = 0; i < markers.length; i++) {
        pinDetailsController.value.add(TextEditingController());
        studentNoteOnPinsController.value.add(TextEditingController());
      }

      itemData.value = [];
      markers.forEach((key, value) {
        itemData.add(ItemModel(
            headerItem: key.value,
            discription:
                "lat: ${value.position.latitude} long : ${value.position.longitude}",
            expanded: false));
      });
    }
  }

  Future<void> _add(GeoPoint data, String index) async {
    final String markerIdVal = 'Special Name :$index';
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5, size: Size(5, 5)),
          "assets/images/pin.png"),
      markerId: markerId,
      position: LatLng(data.latitude, data.longitude),
      infoWindow: InfoWindow(
          onTap: () {},
          title: markerIdVal,
          snippet: 'lat: ${data.latitude} long: ${data.longitude}'),
      // onTap: () => _onMarkerTapped(markerId),
      onDragEnd: (LatLng position) => print("gell"),
      // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    markers.value[markerId] = marker;
  }

  Future<void> setMarkers() async {
    List points = courseData.value.coordinates;
    numberOfTeacherPin(points.length);
    numberOfCurrenctPin(points.length);
    for (var i = 0; i < points.length; i++) {
      _add(
          points[i], courseData.value.pinDetail[(i + 1).toString()].toString());
      markerIdCounter += 1;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  updateCurrentPosition() async {
    var post = await getCenter();
    currentPosition.value = [post.latitude, post.longitude];
  }

  Future<LatLng> getCenter() async {
    // final GoogleMapController c = await controller.mapC.future;

    LatLngBounds visibleRegion = await c.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );

    return centerLatLng;
  }

  setAttachmentPath(List<String?> data) {
    var temp = attachments.value;
    for (var i = 0; i < data.length; i++) {
      temp.add(data[i]);
    }
    attachments.value = temp.toSet().toList();
  }

  String generateCourseCode(int len) {
    var r = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  uploadAttachements() async {
    var result = [];
    var attachment = attachments.value;
    for (var i = 0; i < attachment.length; i++) {
      var path = attachment[i];
      int start = attachment[i]!.lastIndexOf("/");
      String name = attachment[i].substring(start + 1);
      // Create a storage reference from our app
      final storageRef = FirebaseStorage.instance.ref();

      var uniqueID = generateCourseCode(6);
// Create a reference to "mountains.jpg"
      final mountainsRef = storageRef.child("${name}_$uniqueID");

// Create a reference to 'images/mountains.jpg'
      final mountainImagesRef = storageRef.child("itugeo/${name}_$uniqueID");

// While the file names are the same, the references point to different files
      assert(mountainsRef.name == mountainImagesRef.name);
      assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

      File file = File(path);

      try {
        var metaData = await mountainsRef.putFile(file);

        result.add(metaData.ref.fullPath);
      } catch (e) {
        print(e);
        // ...
      }
    }
    return result;
  }
}
