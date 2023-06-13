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

class AddCourseController extends GetxController {
  RxInt activeCurrentStep = 0.obs;
  RxBool showMessageArea = false.obs;
  RxList attachments = [].obs;
  RxList<TextEditingController> pinDetailsController =
      <TextEditingController>[].obs;

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
  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  RxList<double> currentPosition = [37.42796133580664, -122.085749655962].obs;
  RxList position = [].obs;
  final Completer<GoogleMapController> mapC = Completer<GoogleMapController>();
  late final GoogleMapController c;
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Rx<String> courseCodeErrorMessage = "".obs;
  final box = Hive.box(HiveKey.accountData);

  @override
  Future<void> onInit() async {
    super.onInit();
    c = await mapC.future;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    c.dispose();
    courseNameController.dispose();
    courseCodeController.dispose();
    courseDescriptionController.dispose();
    latController.dispose();
    pinCodeController.dispose();
    pinDescriptionController.dispose();
  }

  calculatePinController() {
    pinDetailsController.value = [];
    for (var i = 0; i < markers.length; i++) {
      pinDetailsController.value.add(TextEditingController());
    }
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

  validate() {
    var code = courseCodeController.text.toString();
    var name = courseNameController.text.toString();
    markers;

    if (code == "" || code == null) {
      Get.snackbar("Field require", "Course Code require");
      return false;
    }
    if (name == "" || name == null) {
      Get.snackbar("Field require", "Course name require");
      return false;
    }

    if (position.isEmpty) {
      Get.snackbar("Field require", "At least 1 pin!");
      return false;
    }
    return true;
  }

  createCourse() async {
    if (validate()) {
      ProgressDialogUtils.showProgressDialog();
      var documentRef = await uploadAttachements(); 
      List<GeoPoint> l = [];
      var data = initialCourseData;
      data.lessonCode = courseCodeController.text.toString();
      data.description = courseDescriptionController.text.toString();
      data.name = courseNameController.text.toString();
      int idx = 0;
      markers.forEach((key, value) {
        data.pinDetail[key.value] = pinDetailsController[idx].text.toString();
        idx++;
      });

      data.isActive = true;
      data.code = generateCourseCode(6);
      data.documentRef = documentRef;
      data.teacherId = box.get(HiveKey.userID);
      for (var i = 0; i < position.length; i++) {
        var g = GeoPoint(position[i][0], position[i][1]);
        l.add(g);
      }
      data.coordinates = l;
      await FireStore().createCourse(data);
      ProgressDialogUtils.hideProgressDialog();
      box.put(HiveKey.createdCourseCode, data.code);
      return data.code;
    }
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
