import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/common/utils/dialog.dart';
import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/modules/enroll_company/controllers/custom_google_map_controller.dart';
import 'package:attendance_fast/modules/enroll_company/models/find_place_data.dart';
import 'package:attendance_fast/oauth2/model/register_company.dart';
import 'package:attendance_fast/oauth2/provider/auth_provider.dart';
import 'package:attendance_fast/oauth2/service/auth_service.dart';
import 'package:attendance_fast/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class EnrollCompanyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final authProvider = AuthProvider();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController representativeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isCheckedPrivacy = false.obs;

  RxBool isCheckedLocation = true.obs;
  RxBool isCheckedWifi = false.obs;

  RxBool isCheckedAtWork = true.obs;
  RxBool isCheckedRemote = false.obs;

  Rx<TextEditingController> maxDistanceController = TextEditingController().obs;

  var listMarker = <Marker>[].obs;

  /// CustomGoogleMapWidget
  var customGoogleMapController = CustomGoogleMapController();

  Rx<FindPlaceData> currentPositionTemp = FindPlaceData(lat: 0, lng: 0).obs;
  RxString addressTemp = "--".obs;

  Rx<FindPlaceData> currentPosition = FindPlaceData(lat: 0, lng: 0).obs;
  RxString address = "--".obs;

  var codeCompanySignUpSuccess = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setPermissionLocation();
    maxDistanceController.value.text = 50.toString();
  }

  var textSearchLocation = TextEditingController();

  late GoogleMapController mapController;

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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition.value.lat = position.latitude;
    currentPosition.value.lng = position.longitude;
    address.value = await getAddress(position.latitude, position.longitude);
  }

  Future<String> getAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    String address =
        '${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.street}';
    return address;
  }

  saveLocation() {
    currentPosition.value = currentPositionTemp.value;
    address.value = addressTemp.value;
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

  void onUpdateAddress(FindPlaceData data) async {
    print("------ FETCHED ----");
    // address.value = data.getDescription;
    // if (data.mainText.isNotEmpty && data.description.isNotEmpty)

    currentPositionTemp.value = data;
    addressTemp.value = await getAddress(
        currentPositionTemp.value.lat, currentPositionTemp.value.lng);

    print("------- CURRENT LAT: " + currentPositionTemp.value.lat.toString());
  }

  void validateAndSaveEnroll() {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      if (isCheckedPrivacy.value) {
        print('Form is valid');
        Get.toNamed(Routes.SETUP_COMPANY);
      } else {
        showDialog<void>(
          context: Get.context!,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('term_of_use_and_privacy'.tr),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('check_privacy'.tr),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
    }
  }

  String? emailValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (!value.isEmail) {
      return "Please enter the email in the correct format";
    } else {
      return null;
    }
  }

  String? passwordValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.length < 8) {
      return "password_least_characters_long".tr;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.length < 8) {
      return "password_least_characters_long".tr;
    } else if (value != passwordController.text) {
      return "re-entered_password_not match".tr;
    } else {
      return null;
    }
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

  registerCompany() async {
    showLoading();
    try {
      RegisterCompany registerCompany = RegisterCompany(
        name: companyNameController.text,
        representative_name: representativeController.text,
        address: address.value,
        category_code: 1,
        status_code: 1,
        latitude: currentPosition.value.lat,
        longitude: currentPosition.value.lng,
        type_check_login:
            checkChooseMethod(isCheckedLocation.value, isCheckedWifi.value),
        type_work:
            checkChooseMethod(isCheckedAtWork.value, isCheckedRemote.value),
        max_distance: maxDistanceController.value.text == ""
            ? Numeral.RADIUS_CHECK
            : double.parse(maxDistanceController.value.text),
        company_code: 0,
        first_name: firstNameController.text,
        last_name: lastNameController.text,
        employee_code: employeeIdController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      final result = await authProvider.registerCompany(registerCompany);
      codeCompanySignUpSuccess.value = result["company_code"];
      Global.companyId = result["id"];
      Get.find<AuthService>().registerAndLogin(
          token: result["token"],
          refreshToken: result["token"],
          id: result["id"].toString(),
          routeName: Routes.ENROLL_SUCCESS);
    } catch (e) {
      showToast("Đăng ký thất bại");
      closeLoading();
    }
    closeLoading();
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
