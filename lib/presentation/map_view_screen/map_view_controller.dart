import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/core/utils/spa.dart';
import 'package:itu_geo/models/course_model.dart';
import 'package:itu_geo/models/user_model.dart';
import 'package:itu_geo/widgets/custom_button.dart';

class MapViewController extends GetxController {
  RxBool showMessageArea = false.obs;
  RxBool showMap = false.obs;

  TextEditingController ratingMessageController = TextEditingController();
  Rx<CourseData> data = initialCourseData.obs;
  final Completer<GoogleMapController> mapC = Completer<GoogleMapController>();
  late final GoogleMapController c;
  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  Rx<GeoPoint> selectedPoint = const GeoPoint(0, 0).obs;
  late List<StudentData> studentData;
  @override
  Future<void> onInit() async {
    super.onInit();
    data.value = await Get.arguments[0];
    studentData = await Get.arguments[1];
    await setMarkers();
    await setStudentMarkers();
    showMap.value = true;
    c = await mapC.future;
  }

  Future<void> _add(
      GeoPoint data, int index, bool isStudentPin, String specialName) async {
    final String markerIdVal = '$index';
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = isStudentPin
        ? Marker(
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(
                    devicePixelRatio: 2.5, size: Size(5, 5)),
                "assets/images/pin.png"),
            markerId: markerId,
            position: LatLng(data.latitude, data.longitude),
            infoWindow: InfoWindow(
                onTap: () {
                  var res = spaCalculate(SPAParams(
                      time: DateTime.now(),
                      longitude: data.longitude,
                      latitude: data.latitude));
                  Get.defaultDialog(
                      actions: [],
                      title: "",
                      content: SizedBox(
                        width: getHorizontalSize(500),
                        height: getVerticalSize(600),
                        child: _buildResulOfCalculationWidget(res),
                      ),
                      middleText: "msg_exit_quiz".tr,
                      backgroundColor: ColorConstant.whiteA700,
                      titleStyle: TextStyle(color: ColorConstant.black900),
                      middleTextStyle: TextStyle(color: ColorConstant.black900),
                      radius: 30);
                },
                title: markerIdVal,
                snippet: 'Special Name :$specialName'),
            // onTap: () => _onMarkerTapped(markerId),
            onDragEnd: (LatLng position) => print("gell"),
            // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
          )
        : Marker(
            markerId: markerId,
            position: LatLng(data.latitude, data.longitude),
            infoWindow: InfoWindow(
                onTap: () {
                  var res = spaCalculate(SPAParams(
                      time: DateTime.now(),
                      longitude: data.longitude,
                      latitude: data.latitude));
                  Get.defaultDialog(
                      actions: [],
                      title: "",
                      content: SizedBox(
                        width: getHorizontalSize(500),
                        height: getVerticalSize(600),
                        child: _buildResulOfCalculationWidget(res),
                      ),
                      middleText: "msg_exit_quiz".tr,
                      backgroundColor: ColorConstant.whiteA700,
                      titleStyle: TextStyle(color: ColorConstant.black900),
                      middleTextStyle: TextStyle(color: ColorConstant.black900),
                      radius: 30);
                },
                title: markerIdVal,
                snippet: 'Special Name :$specialName'),
            // onTap: () => _onMarkerTapped(markerId),
            onDragEnd: (LatLng position) => print("gell"),
            // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
          );

    markers.value[markerId] = marker;
  }

  Future<void> setMarkers() async {
    List points = data.value.coordinates;
    for (var i = 0; i < points.length; i++) {
      _add(points[i], i, false,
          data.value.pinDetail[(i + 1).toString()].toString());
    }
  }

  Future<void> setStudentMarkers() async {
    List points = [];
    List specialName = [];
    for (var i = 0; i < studentData.length; i++) {
      for (var j = 0; j < studentData[i].coordinates.length; j++) {
        points.add(studentData[i].coordinates[j]);
        if (j < specialName.length) {
          specialName.add(specialName[j]);
        } else {
          specialName.add(j.toString());
        }
      }
    }

    for (var i = 0; i < points.length; i++) {
      _add(points[i], i + markers.value.length + 1, true,
          specialName[i].toString());
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    ratingMessageController.dispose();
  }

  _buildResulOfCalculationWidget(SPAOutput res) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Azimuth : ${res.azimuth}",
                  style: const TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: double.maxFinite,
                  variant: ButtonVariant.GradientGray,
                  text: "Copy",
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: res.azimuth.toString()));
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Azimuth Astro : ${res.azimuthAstro}",
                  style: const TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: double.maxFinite,
                  variant: ButtonVariant.GradientGray,
                  text: "Copy",
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: res.azimuthAstro.toString()));
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Zenith : ${res.zenith}",
                  style: const TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: double.maxFinite,
                  variant: ButtonVariant.GradientGray,
                  text: "Copy",
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: res.zenith.toString()));
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Sunrise : ${res.sunrise}",
                  style: const TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: double.maxFinite,
                  variant: ButtonVariant.GradientGray,
                  text: "Copy",
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: res.sunrise.toString()));
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Sunset : ${res.sunset}",
                  style: const TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: double.maxFinite,
                  variant: ButtonVariant.GradientGray,
                  text: "Copy",
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: res.sunset.toString()));
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Sun Transit : ${res.sunTransit}",
                  style: const TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  width: double.maxFinite,
                  variant: ButtonVariant.GradientGray,
                  text: "Copy",
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: res.sunTransit.toString()));
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
