import 'package:attendance_fast/modules/enroll_company/controllers/custom_google_map_controller.dart';
import 'package:attendance_fast/modules/enroll_company/models/find_place_data.dart';
import 'package:attendance_fast/modules/enroll_company/services/location_service.dart';
import 'package:attendance_fast/modules/enroll_company/services/map_pin_picker.dart';
import 'package:attendance_fast/modules/enroll_company/widgets/custom_marker.dart';
import 'package:attendance_fast/modules/enroll_company/widgets/custom_title.dart';
import 'package:attendance_fast/modules/enroll_company/widgets/pass_data.dart';
import 'package:attendance_fast/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  CustomGoogleMap(
      {required this.customGoogleMapController,
      required this.onUpdateAddress,
      required this.initialPosition}) {
    // PassDataCustomPageView.data.listen((value) {
    //   if (value['role'] == 'CustomGoogleMap') if (value['page'] == 1 &&
    //       customGoogleMapController.infoWindowController.addInfoWindow != null)
    //     customGoogleMapController.infoWindowController.addInfoWindow!(
    //       CustomInfoWindowWidget(
    //         numOfDriver: 0,
    //       ),
    //       LatLng(LocationService.instance.getLastKnowPosition.latitude,
    //           LocationService.instance.getLastKnowPosition.longitude),
    //     );
    //   else if (customGoogleMapController.infoWindowController.hideInfoWindow !=
    //       null)
    //     customGoogleMapController.infoWindowController.hideInfoWindow!();
    // });
  }

  final Function(FindPlaceData data) onUpdateAddress;

  final CustomGoogleMapController customGoogleMapController;

  final FindPlaceData initialPosition;

  void _onMapCreated(GoogleMapController controller) {
    customGoogleMapController.mapController.complete(controller);
    customGoogleMapController.customInfoWindowController.googleMapController =
        controller;
    customGoogleMapController.infoWindowController.googleMapController =
        controller;
    if (!customGoogleMapController.isMapCreated) {
      customGoogleMapController.isMapCreated = true;

        customGoogleMapController.position = CameraPosition(
            target: LatLng(initialPosition.lat, initialPosition.lng), zoom: 17);
        customGoogleMapController.animateCamera(
            CameraUpdate.newCameraPosition(customGoogleMapController.position));

    }
  }

  void _updateCameraPosition(CameraPosition position) {
    // print(position.target.latitude.toString() + "-" + position.target.longitude.toString());
    // print(customGoogleMapController.isUpdateAddress.toString());
    if (customGoogleMapController.isUpdateAddress) {
      // onUpdateAddress(FindPlaceData(
      //     lng: position.target.longitude, lat: position.target.latitude));
    }
    customGoogleMapController.position = position;
    // customGoogleMapController.customInfoWindowController.onCameraMove!();
    // if (customGoogleMapController.infoWindowController.onCameraMove != null)
    //   customGoogleMapController.infoWindowController.onCameraMove!();
  }

  void _onCameraMoveStarted() =>
      customGoogleMapController.mapPickerController.mapMoving();

  void _onCameraIdle() {
    customGoogleMapController.mapPickerController.mapFinishedMoving();
    if (customGoogleMapController.isUpdateAddress) {
      onUpdateAddress(FindPlaceData(
          lng: customGoogleMapController.position.target.longitude,
          lat: customGoogleMapController.position.target.latitude));
      _searchAddressFromPosition();
      //
      // if (customGoogleMapController.placeData != null) {
      //   onUpdateAddress(customGoogleMapController.placeData!);
      //   customGoogleMapController.placeData = null;
      // } else {
      //   _searchAddressFromPosition();
      // }
    }
  }

  void _searchAddressFromPosition() {
    // onUpdateAddress(FindPlaceData());
    // CustomGoogleMapRepository.instance
    //     .searchNearbyWithRankBy(Location(
    //         lng: customGoogleMapController.position.target.longitude,
    //         lat: customGoogleMapController.position.target.latitude))
    //     .then((response) {
    //   if (response.isNotEmpty)
    //     // onUpdateAddress(response.firstWhere((element) => element.description != 'null'));
    //     onUpdateAddress(response.firstWhere((element) {
    //       element.lng = customGoogleMapController.position.target.longitude;
    //       element.lat = customGoogleMapController.position.target.latitude;
    //       return element.description != 'null';
    //     }));
    //   print('${response.first.lat},${response.first.lng}');
    //   print(
    //       '${customGoogleMapController.position.target.latitude},${customGoogleMapController.position.target.longitude}');
    // }).onError((error, stackTrace) {
    //   log.error(error);
    //   InternetService.checkInternet();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MapPicker(
        mapPickerController: customGoogleMapController.mapPickerController,
        showDot: true,
        // topWidget: Obx(
        //   () =>
        //   customGoogleMapController.markers
        //           .any((e) => e.markerId.value == 'startPoint')
        //       ?
        //       SizedBox(
        //           height: 65,
        //         )
        //       : StreamBuilder<List<DriverInfoDTO>>(
        //           stream: CustomGoogleMapRepository.instance.driverStream(),
        //           builder: (context, snapshot) {
        //             return CustomInfoWindowWidget(
        //               numOfDriver: snapshot.hasData ? snapshot.data!.length : 0,
        //             );
        //           },
        //         ),
        // ),
        iconWidget: Obx(
          () => CustomMarker(
            color: customGoogleMapController.markers
                    .any((e) => e.markerId.value == 'startPoint')
                ? CustomColors.blue
                : CustomColors.red,
          ),
        ),
        child:
            // Stack(
            //   children: [
            // Obx(() =>
            // LocalStorage.instance.userInfoDTO.activeModeType == 0
            //     ?
            GoogleMap(
          buildingsEnabled: false,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              initialPosition.lat,
              initialPosition.lng,
            ),
            zoom: 17.0,
          ),
          onCameraMove: _updateCameraPosition,
          onCameraMoveStarted: _onCameraMoveStarted,
          onCameraIdle: _onCameraIdle,
          zoomControlsEnabled: false,
          markers: Set<Marker>.of(customGoogleMapController.markers),
          polylines: Set<Polyline>.of(customGoogleMapController.polyline),
        )
        //     :
        // GoogleMap(
        //     zoomGesturesEnabled: false,
        //     scrollGesturesEnabled: false,
        //     tiltGesturesEnabled: false,
        //     rotateGesturesEnabled: false,
        //     buildingsEnabled: false,
        //     mapType: MapType.normal,
        //     myLocationButtonEnabled: false,
        //     myLocationEnabled: true,
        //     onMapCreated: _onMapCreated,
        //     initialCameraPosition:
        //         CustomGoogleMapController.kInitialPosition,
        //     onCameraMove: _updateCameraPosition,
        //     onCameraMoveStarted: _onCameraMoveStarted,
        //     onCameraIdle: _onCameraIdle,
        //     zoomControlsEnabled: false,
        //     markers: Set<Marker>.of(customGoogleMapController.markers),
        //     polylines:
        //         Set<Polyline>.of(customGoogleMapController.polyline),
        //   )
        // ),
        // CustomInfoWindow(
        //     controller: customGoogleMapController.customInfoWindowController,
        //     height: 100,
        //     width: 150,
        //     offset: 5),
        // StreamBuilder<List<DriverInfoDTO>>(
        //   stream: CustomGoogleMapRepository.instance.driverStream(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       if ((snapshot.data?.length ?? 0) == 0) {
        //         return CustomInfoWindow(
        //           controller: customGoogleMapController.infoWindowController,
        //           width: 200,
        //           height: 100,
        //           offset: 0,
        //         );
        //       }
        //     }
        //     return SizedBox();
        //   },
        // ),
        // ],
        // ),
        );
  }
}
