// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itu_geo/core/utils/color_constant.dart';
import 'package:itu_geo/core/utils/size_utils.dart';
import 'package:itu_geo/core/utils/spa.dart';
import 'package:itu_geo/presentation/map_view_screen/map_view_controller.dart';

class MapViewScreen extends GetWidget<MapViewController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leadingWidth: 50,
              leading: InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding: getPadding(left: 8, right: 8),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  )),
              title: const Center(
                  child: Text(
                "MapView Screen",
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.white,
            ),
            backgroundColor: ColorConstant.whiteA700,
            body: Obx(() => controller.showMap.value
                ? NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollState) {
                      return true;
                    },
                    child: Stack(
                      children: [
                        GoogleMap(
                          markers:
                              Set<Marker>.of(controller.markers.value.values),
                          onTap: (argument) {
                            print(argument.longitude);
                          },
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          mapType: MapType.terrain,
                          initialCameraPosition: CameraPosition(
                            target:
                                controller.markers.value.values.first.position,
                            zoom: 16.4746,
                          ),
                          onMapCreated: (GoogleMapController c) {
                            controller.mapC.complete(c);
                          },
                        ),
                        Padding(
                          padding: getPadding(bottom: 47),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/pin.svg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.fitWidth,
                              // color: color,
                            ),
                          ),
                        ),

                    

                        // Obx(() => Padding(
                        //       padding: const EdgeInsets.all(24.0),
                        //       child: Container(
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               controller.currentPosition.value[0].toString(),
                        //               textAlign: TextAlign.end,
                        //             ),
                        //             Text(
                        //               controller.currentPosition.value[1].toString(),
                        //               textAlign: TextAlign.end,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ))
                      ],
                    ))
                : Container())));
  }
}
