import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/common/utils/dialog.dart';
import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/modules/company_profile/models/company.dart';
import 'package:attendance_fast/modules/company_setting/provider/company_setting_provider.dart';
import 'package:attendance_fast/modules/enroll_company/controllers/custom_google_map_controller.dart';
import 'package:attendance_fast/modules/enroll_company/models/find_place_data.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class CompanySettingController extends GetxController {
  var companyInfo = CompanyModel().obs;

  RxBool isCheckedPrivacy = false.obs;

  RxBool isCheckedLocation = false.obs;
  RxBool isCheckedWifi = false.obs;

  RxBool isCheckedAtWork = true.obs;
  RxBool isCheckedRemote = false.obs;

  /// CustomGoogleMapWidget
  var customGoogleMapController = CustomGoogleMapController();
  late GoogleMapController mapController;

  Rx<FindPlaceData> currentPositionTemp = FindPlaceData(lat: 0, lng: 0).obs;
  RxString addressTemp = "--".obs;

  Rx<FindPlaceData> currentPosition = FindPlaceData(lat: 0, lng: 0).obs;
  RxString address = "--".obs;

  var listMarker = <Marker>[].obs;

  var textSearchLocation = TextEditingController();
  Rx<TextEditingController> maxDistanceController = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getInfoCompany();
    setInfoCompany();
    setPermissionLocation();
    maxDistanceController.value.text = companyInfo.value.maxDistance.toString();
  }

  getPossitionFromAddressCustom() async {
    List<Location> locations =
        await locationFromAddress(textSearchLocation.value.text);
    if (locations.isNotEmpty) {
      listMarker.value = [
        Marker(
          markerId: const MarkerId(''),
          position: LatLng(locations[0].latitude, locations[0].longitude),
          infoWindow: const InfoWindow(title: ''),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        )
      ];

      currentPositionTemp.value.lat = locations[0].latitude;
      currentPositionTemp.value.lng = locations[0].longitude;
      addressTemp.value =
          await getAddress(locations[0].latitude, locations[0].longitude);

      customGoogleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locations[0].latitude, locations[0].longitude),
            zoom: Numeral.ZOOM_GOOGLE_MAP,
          ),
        ),
      );
    }
  }

  saveLocation() {
    currentPosition.value = currentPositionTemp.value;
    address.value = addressTemp.value;
  }

  void onUpdateAddress(FindPlaceData data) async {
    print("------ FETCHED ----");
    // address.value = data.getDescription;
    // if (data.mainText.isNotEmpty && data.description.isNotEmpty)

    currentPositionTemp.value = data;
    addressTemp.value = await getAddress(
        currentPositionTemp.value.lat, currentPositionTemp.value.lng);

    print("------- CURRENT LAT: " + currentPositionTemp.value.lat.toString());
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  createGoogleMapController() {
    customGoogleMapController = CustomGoogleMapController();
  }

  Future<void> setPermissionLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      await getPosition();
    }
  }

  getPosition() async {
    currentPosition.value.lat = companyInfo.value.latitude ?? 0;
    currentPosition.value.lng = companyInfo.value.longitude ?? 0;
    address.value =
        await getAddress(currentPosition.value.lat, currentPosition.value.lng);
  }

  Future<String> getAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    String address =
        '${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.street}';
    return address;
  }

  getInfoCompany() async {
    companyInfo.value = await CompanySettingProvider()
        .getInfoCompanyUserLogin(Global.companyId.toString());
  }

  setInfoCompany() {
    switch (companyInfo.value.typeWork!) {
      case 1:
        isCheckedAtWork.value = true;
        break;
      case 2:
        isCheckedRemote.value = true;
        break;
      case 3:
        {
          isCheckedAtWork.value = true;
          isCheckedRemote.value = true;
          break;
        }
      default:
    }
    switch (companyInfo.value.typeCheckLogin!) {
      case 1:
        isCheckedLocation.value = true;
        isCheckedWifi.value = false;
        break;
      case 2:
        isCheckedWifi.value = true;
        isCheckedLocation.value = false;
        break;
      case 3:
        {
          isCheckedLocation.value = true;
          isCheckedWifi.value = true;
          break;
        }
      default:
    }
  }

  Future<bool> updateSettingCompany() async {
    companyInfo.value.typeCheckLogin =
        checkChooseMethod(isCheckedLocation.value, isCheckedWifi.value);
    companyInfo.value.typeWork =
        checkChooseMethod(isCheckedAtWork.value, isCheckedRemote.value);

    companyInfo.value.latitude = currentPosition.value.lat;
    companyInfo.value.longitude = currentPosition.value.lng;
    companyInfo.value.address = address.value;
    companyInfo.value.maxDistance = int.parse(maxDistanceController.value.text);

    var result = await CompanySettingProvider()
        .updateInfoCompany(companyInfo.value.id!.toString(), companyInfo.value);
    return result;
  }

  void updatePrivacyChecking() {
    isCheckedPrivacy.toggle();
  }

  void updateLocationChecking() {
    if (isCheckedWifi.value) {
      isCheckedLocation.toggle();
    }
  }

  void updateWifiChecking() {
    if (isCheckedLocation.value) {
      isCheckedWifi.toggle();
    }
  }

  void updateAtWorkChecking() {
    if (isCheckedRemote.value) {
      isCheckedAtWork.toggle();
    }
  }

  void updateRemoteChecking() {
    if (isCheckedAtWork.value) {
      isCheckedRemote.toggle();
    }
  }

  int checkChooseMethod(bool checkMethodFirst, bool checkMethodSecond) {
    if (checkMethodFirst && !checkMethodSecond) {
      return 1;
    } else if (!checkMethodFirst && checkMethodSecond) {
      return 2;
    }
    return 3;
  }
}
