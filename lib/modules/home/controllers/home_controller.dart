import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/common/utils/dialog.dart';
import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_button.dart';
import 'package:attendance_fast/common/widgets/base_button_login.dart';
import 'package:attendance_fast/common/widgets/base_dialog.dart';
import 'package:attendance_fast/languages/language_service.dart';
import 'package:attendance_fast/main.dart';
import 'package:attendance_fast/modules/home/models/attendance_model.dart';
import 'package:attendance_fast/modules/home/models/card_statistic_model.dart';
import 'package:attendance_fast/modules/home/models/statistic_model.dart';
import 'package:attendance_fast/modules/home/models/shift_model.dart';
import 'package:attendance_fast/modules/home/models/user_model.dart';
import 'package:attendance_fast/modules/home/provider/home_provider.dart';
import 'package:attendance_fast/modules/leave_request/models/manager_model.dart';
import 'package:attendance_fast/modules/leave_request/provider/leave_request_provider.dart';
import 'package:attendance_fast/oauth2/provider/auth_provider.dart';
import 'package:attendance_fast/oauth2/service/auth_service.dart';
import 'package:attendance_fast/oauth2/service/notification_service.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeController extends GetxController {
  final authService = AuthProvider();
  var userInfo = UserModel().obs;
  var lastAttendance = AttendanceModel().obs;
  RxString lastCheckIn = "--:--".obs;
  RxString lastCheckOut = "--:--".obs;
  RxString lastDuration = "--:--".obs;

  RxInt checkInStatus = 2.obs;

  RxString date = "---".obs;

  var statisticCards = <CardStatisticModel>[].obs;

  var homeStatistic = StatisticModel().obs;
  var listShift = [].obs;

  Rx<ShiftModel> selectedShift = ShiftModel().obs;

  var currentLocationLat = 0.0.obs;
  var currentLocationLong = 0.0.obs;
  var distance = 0.0.obs;
  RxString address = "--".obs;

  RxBool isValidManagerLate = true.obs;

  var listManager = <ManagerModel>[].obs;
  RxInt selectedManagerId = 0.obs;
  Rx<String> selectedDropBox = "send_to".tr.obs;
  final TextEditingController searchDropBoxController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Rx<DateTime> dateTimeCheckoutLate = DateTime.now().obs;

  var isTypeWorkWifi = 0.obs;
  NotificationService notificationService = NotificationService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDateNow();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    if (!kIsWeb) {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage event) {
          RemoteNotification notification = event.notification!;
          AndroidNotification? android = event.notification!.android;
          if (android != null) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher'),
              ),
            );
          }
        },
      );
    }

    switch (Get.find<AuthService>().languageApp) {
      case 1:
        LanguageService.changeLocale("en");
        break;
      case 2:
        LanguageService.changeLocale("vi");
        break;
      case 3:
        LanguageService.changeLocale("jp");
        break;
      default:
        LanguageService.changeLocale("en");
        break;
    }

    showLoading();
    await Future.wait([
      callApiUserProvider(),
      callApiLastCheckInProvider(),
      getHomeStatistic(),
    ]);
    closeLoading();
    setPermissionLocation();

    if (userInfo.value.shiftId != null) {
      DateTime timeBegin =
          DateFormat("HH:mm:ss").parse(userInfo.value.shiftInfo!.timeStart!);
      DateTime dateTimeBegin = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          timeBegin.hour,
          timeBegin.minute);
      DateTime dateTimeBeginSchedule = dateTimeBegin.subtract(
        const Duration(minutes: 5),
      );
      if (dateTimeBeginSchedule.compareTo(DateTime.now()) > 0) {
        notificationService.scheduleNotification(
          id: 1,
          title: 'noti'.tr,
          body: "checkin".tr,
          scheduledNotificationDateTime: dateTimeBeginSchedule,
        );
      }

      DateTime timeEnd =
          DateFormat("HH:mm:ss").parse(userInfo.value.shiftInfo!.timeEnd!);
      DateTime dateTimeEnd = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, timeEnd.hour, timeEnd.minute);
      DateTime dateTimeEndSchedule = dateTimeEnd.add(
        const Duration(minutes: 5),
      );
      if (dateTimeEndSchedule.compareTo(DateTime.now()) > 0) {
        notificationService.scheduleNotification(
          id: 2,
          title: 'noti'.tr,
          body: "checkout".tr,
          scheduledNotificationDateTime: dateTimeEndSchedule,
        );
      }
    }
  }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  Future<bool> setPermissionLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        currentLocationLat.value = position.latitude;
        currentLocationLong.value = position.longitude;
        if(!kIsWeb){
          address.value = await getAddress(position.latitude, position.longitude);
        }
        return true;
      } catch (e) {
        return false;
      }
    }

    return false;
  }

  Future<String> getAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    String address =
        '${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.street}';
    return address;
  }

  Future<void> getHomeStatistic() async {
    homeStatistic.value = await HomeProvider().getStatictisUserLogin();
    statisticCards.value = [
      CardStatisticModel(
          1,
          "working_days".tr,
          homeStatistic.value.workingDays.toString(),
          AppColor.working_days,
          Icons.calendar_month),
      CardStatisticModel(
          2,
          "working_hours".tr,
          homeStatistic.value.workingHours!.toStringAsFixed(2),
          AppColor.working_hours,
          Icons.alarm_on),
      CardStatisticModel(
          3,
          "leave_requests".tr,
          homeStatistic.value.leaveRequest.toString(),
          AppColor.leave_requests,
          Icons.assignment),
      CardStatisticModel(
          4,
          "hours_off".tr,
          homeStatistic.value.hoursOff!.toStringAsFixed(2),
          AppColor.hours_off,
          Icons.history_toggle_off),
      CardStatisticModel(
          5,
          "ot_requests".tr,
          homeStatistic.value.overtimeRequest.toString(),
          AppColor.ot_requests,
          Icons.task),
      CardStatisticModel(
          6,
          "ot_hours".tr,
          homeStatistic.value.overtimeHours!.toStringAsFixed(2),
          AppColor.ot_hours,
          Icons.alarm_add),
      CardStatisticModel(
          7,
          "late_arrival".tr,
          homeStatistic.value.lateArrivals.toString(),
          AppColor.late_arrival,
          Icons.snooze),
      CardStatisticModel(
          8,
          "early_leaving".tr,
          homeStatistic.value.earlyLeaving.toString(),
          AppColor.early_leaving,
          Icons.hourglass_bottom),
    ];
  }

  updateCheckInStatus() async {
    // Call to get company location
    await callApiUserProvider();
    if (userInfo.value.shiftId != null) {
      selectedShift.value.id = userInfo.value.shiftId;
    }
    showLoading();
    await Future.wait([
      callApiLastCheckInProvider(),
    ]);

    // Check distance
    bool checkLocationPermission = await setPermissionLocation();
    closeLoading();

    if (checkLocationPermission) {
      if (!kIsWeb) {
        distance.value = Geolocator.distanceBetween(
            currentLocationLat.value,
            currentLocationLong.value,
            userInfo.value.companyInfo!.latitude!,
            userInfo.value.companyInfo!.longitude!);
      }
      if (checkInStatus.value == 1) {
        if (distance.value > userInfo.value.companyInfo!.maxDistance! && !kIsWeb) {
          reasonController.text = "";
          selectedDropBox.value = "send_to".tr;
          checkOutRemote();
          // callApiCheckOutProvider();
        } else {
          callApiCheckOutProvider();
        }
      } else {
        await callApiGetListShift();
        if (distance.value > userInfo.value.companyInfo!.maxDistance! && !kIsWeb) {
          if (userInfo.value.companyInfo!.typeWork ==
              Numeral.TYPE_WORK_AT_WORK) {
            Get.snackbar("noti".tr, "get_close_company".tr);
          } else if (userInfo.value.companyInfo!.typeWork ==
              Numeral.TYPE_WORK_AT_WORK_REMOTE) {
            checkInRemote(shiftId: selectedShift.value.id);
          }
        } else {
          if (userInfo.value.shiftId != null) {
            var result = await HomeProvider().checkIn(
                userInfo.value.shiftId,
                currentLocationLat.value,
                currentLocationLong.value,
                Numeral.TYPE_WORK_AT_WORK);

            if (result) {
              callApiLastCheckInProvider();
            } else {
              BaseDialog.getBaseDialog(
                  context: Get.context!,
                  title: "check_in_fail".tr,
                  desc: "check_in_fail_desc".tr,
                  dialogType: DialogType.error,
                  buttonColor: AppColor.lightRed,
                  textColor: AppColor.lightRed);
            }
            Get.back();
            Get.back();
          } else {
            chooseShift(Numeral.TYPE_WORK_AT_WORK);
          }
        }
      }
    }
  }

  updateCheckInStatusWifi() async {
    // Call to get company location
    await callApiUserProvider();
    if (userInfo.value.shiftId != null) {
      selectedShift.value.id = userInfo.value.shiftId;
    }

    showLoading();
    await Future.wait([
      callApiLastCheckInProvider(),
    ]);

    // Check distance
    bool checkLocationPermission = await setPermissionLocation();
    closeLoading();

    if (checkLocationPermission) {
      if (checkInStatus.value == 1) {
        if (isTypeWorkWifi.value == Numeral.TYPE_WORK_REMOTE) {
          reasonController.text = "";
          selectedDropBox.value = "send_to".tr;
          checkOutRemote();
          // callApiCheckOutProvider();
        } else {
          callApiCheckOutProvider();
        }
      } else {
        chooseTypeWorkCheckinWifi();
      }
    }
  }

  checkOutRemote() {
    callApiManagerOfCompany();
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: Numeral.WIDTH_SCREEN * 0.7,
                // height: Get.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "remote_checkout".tr,
                        style: TextStyle(
                            color: AppColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "noti_remote_checkout".tr,
                        style: TextStyle(
                            color: AppColor.lightText,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 16),
                      getManagerWidget(),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "date".tr,
                            style: TextStyle(
                                color: AppColor.primaryGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: Numeral.WIDTH_SCREEN * 0.8,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: AppColor.lightPurple,
                                borderRadius: BorderRadius.circular(12),
                                border: (!isValidManagerLate.value)
                                    ? Border.all(
                                        color: AppColor.lightRed, width: 1.5)
                                    : null,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      blurRadius: 4)
                                ]),
                            child: Obx(
                              () => GestureDetector(
                                onTap: () async {
                                  dateTimeCheckoutLate.value =
                                      await showDateTimePicker(
                                              context: context) ??
                                          DateTime.now();
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month,
                                        color: AppColor.primaryGrey
                                            .withOpacity(0.8)),
                                    const SizedBox(width: 14),
                                    Text(
                                      DateFormat("yyyy-MM-dd  hh:mm:ss")
                                          .format(dateTimeCheckoutLate.value),
                                      style: TextStyle(
                                          color: AppColor.primaryBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      getReasonWidget(),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          sendCheckoutRemote();
                        },
                        child: BaseButton(
                          height: Get.height * 0.055,
                          width: Numeral.WIDTH_SCREEN * 0.6,
                          title: "checkout".tr,
                          fontSize: 15,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  sendCheckoutRemote() async {
    // Check valid manager field
    if (selectedDropBox.value.isEmpty ||
        selectedDropBox.value == "send_to".tr) {
      isValidManagerLate.value = false;
    } else {
      isValidManagerLate.value = true;
    }

    if (isValidManagerLate.value) {
      print("----------- VALID");

      bool result = await HomeProvider().checkOutLate(
          managerId: selectedManagerId.value,
          timeLeave: dateTimeCheckoutLate.value,
          reason: reasonController.text,
          latitudeCheckout: currentLocationLat.value,
          longitudeCheckout: currentLocationLong.value);

      if (result) {
        await callApiLastCheckInProvider();
        Get.back();
      } else {
        BaseDialog.getBaseDialog(
            context: Get.context!,
            title: "check_out_fail".tr,
            desc: "check_out_fail_desc".tr,
            dialogType: DialogType.error,
            buttonColor: AppColor.lightRed,
            textColor: AppColor.lightRed);
      }
    } else {
      print("----------- INVALID");
    }
  }

  getReasonWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "reason".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: Numeral.WIDTH_SCREEN * 0.8,
          height: Get.height * 0.12,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: TextField(
            maxLength: 500,
            maxLines: null,
            controller: reasonController,
            decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 14, color: AppColor.primaryGrey),
                border: InputBorder.none,
                hintText: "reason".tr),
          ),
        )
      ],
    );
  }

  updateSelectedManager(ManagerModel manager) {
    selectedDropBox.value =
        "${manager.name} - ${manager.managerInfo?.firstName} ${manager.managerInfo?.lastName}";
    selectedManagerId.value = manager.managerInfo!.id!;
  }

  /// Get manager of company
  Future<void> callApiManagerOfCompany() async {
    var result =
        await LeaveRequestProvider().getListManagerofCompanyUserLogin();
    if (result.isNotEmpty) {
      listManager.value = result;
    }
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

  getManagerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "reason".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => Container(
            width: Numeral.WIDTH_SCREEN * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                color: AppColor.lightPurple,
                borderRadius: BorderRadius.circular(12),
                border: (!isValidManagerLate.value)
                    ? Border.all(color: AppColor.lightRed, width: 1.5)
                    : null,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                ]),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<ManagerModel>(
                isExpanded: true,
                hint: TextFormField(
                    cursorColor: Colors.black,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: selectedDropBox.value,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                          left: 10, bottom: 13, top: 13, right: 10),
                      prefixIcon: Icon(Icons.supervisor_account,
                          color: AppColor.primaryGrey.withOpacity(0.8)),
                      labelStyle: TextStyle(
                          color: (isValidManagerLate.value)
                              ? AppColor.primaryGrey
                              : AppColor.lightRed,
                          fontSize: 14),
                    )),
                items: listManager
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            "${item.name} - ${item.managerInfo?.firstName} ${item.managerInfo?.lastName}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    updateSelectedManager(value);
                  }
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  width: 200,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: searchDropBoxController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: searchDropBoxController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    String displayedLabel =
                        "${item.value?.name} - ${item.value?.managerInfo?.firstName} ${item.value?.managerInfo?.lastName}";

                    displayedLabel = displayedLabel.toLowerCase();
                    searchValue = searchValue.toLowerCase();

                    return displayedLabel.contains(searchValue);
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    searchDropBoxController.clear();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  checkInRemote({required int? shiftId}) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: Numeral.WIDTH_SCREEN * 0.7,
                height: Get.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Text(
                      "not_office_range".tr,
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "do_you_want_to_work_from_home".tr,
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (userInfo.value.shiftId == null) {
                            chooseShift(Numeral.TYPE_WORK_REMOTE);
                          } else {
                            var result = await HomeProvider().checkIn(
                                userInfo.value.shiftId,
                                currentLocationLat.value,
                                currentLocationLong.value,
                                Numeral.TYPE_WORK_REMOTE);

                            if (result) {
                              callApiLastCheckInProvider();
                            } else {
                              BaseDialog.getBaseDialog(
                                  context: Get.context!,
                                  title: "check_in_fail".tr,
                                  desc: "check_in_fail_desc".tr,
                                  dialogType: DialogType.error,
                                  buttonColor: AppColor.lightRed,
                                  textColor: AppColor.lightRed);
                            }
                            Get.back();
                            Get.back();
                          }
                        },
                        child: AvatarGlow(
                          endRadius: Numeral.WIDTH_SCREEN * 0.3,
                          glowColor: AppColor.primaryGreen,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration:
                              const Duration(milliseconds: 100),
                          child: CircleAvatar(
                            backgroundImage: const AssetImage(
                                'assets/images/common/img_checkin_remote_button.png'),
                            radius: Numeral.WIDTH_SCREEN * 0.18,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  /// Choose shift
  chooseShift(int typeCheckin) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: Numeral.WIDTH_SCREEN * 0.7,
              height: Get.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: createRadioListUsers(typeCheckin),
            ),
          );
        });
  }

  Widget createRadioListUsers(int typeCheckin) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Text(
                "Shift",
                style: TextStyle(
                    color: AppColor.primaryText,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: listShift.length,
              itemBuilder: (BuildContext context, int index) {
                ShiftModel shift = listShift[index];
                return GestureDetector(
                  onTap: () {
                    selectedShift.value = shift;
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Image.asset(
                                (selectedShift.value == shift)
                                    ? "assets/icons/ic_check_box.png"
                                    : "assets/icons/ic_uncheck_box.png",
                                width: 22,
                                height: 22),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shift.name ?? "",
                                style: TextStyle(
                                    color: AppColor.primaryPurple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "(${shift.timeStart}  -  ${shift.timeEnd})",
                                style: TextStyle(
                                    fontSize: 13, color: AppColor.primaryText),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Divider(),
                      )
                    ],
                  ),
                );
                // title: Text("List item $index"));
              }),
        ),
        const SizedBox(
          height: 7,
        ),
        GestureDetector(
          onTap: () async {
            if (selectedShift.value.id == null) {
              AwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: "no_shift_selected".tr,
                desc: "no_shift_selected_desc".tr,
                btnOkColor: AppColor.lightRed,
                btnOkOnPress: () {},
                onDismissCallback: (type) {},
              ).show();
            } else {
              await callApiCheckInProvider(typeCheckin);
              Get.back();
              Get.back();
            }
          },
          child: BaseButtonLogin(
            height: Get.height * 0.055,
            width: Numeral.WIDTH_SCREEN * 0.5,
            title: "check_in".tr,
            borderRadius: 16,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Future<void> callApiGetListShift() async {
    var result = await HomeProvider().getListShift();

    if (result.isEmpty) {
      return;
    }
    listShift.value = result;
    selectedShift.value = listShift[0];
  }

  /// Check In
  callApiCheckInProvider(int typeCheckin) async {
    var result = await HomeProvider().checkIn(selectedShift.value.id ?? 1,
        currentLocationLat.value, currentLocationLong.value, typeCheckin);

    if (result) {
      callApiLastCheckInProvider();
    } else {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "check_in_fail".tr,
          desc: "check_in_fail_desc".tr,
          dialogType: DialogType.error,
          buttonColor: AppColor.lightRed,
          textColor: AppColor.lightRed);
    }
  }

  /// Check Out
  void callApiCheckOutProvider() async {
    var result = await HomeProvider()
        .checkOut(currentLocationLat.value, currentLocationLong.value);
    if (result) {
      callApiLastCheckInProvider();
    } else {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "check_out_fail".tr,
          desc: "check_out_fail_desc".tr,
          dialogType: DialogType.error,
          buttonColor: AppColor.lightRed,
          textColor: AppColor.lightRed);
    }
  }

  /// Get user infor
  Future<void> callApiUserProvider() async {
    var result = await HomeProvider().getUserInfo();
    userInfo.value = result;

    if (result.id != null) {
      Global.userId = result.id!;
    }

    if (result.companyId != null) {
      Global.companyId = result.companyId!;
    }

    if (result.firstName != null && result.lastName != null) {
      Global.userName = "${result.firstName} ${result.lastName}";
    }
  }

  /// Get last check in
  Future<void> callApiLastCheckInProvider() async {
    var result = await HomeProvider().getLastCheckIn();
    lastAttendance.value = result;

    checkInStatus.value = lastAttendance.value.statusCode ?? 2;
    lastCheckIn.value = formatCheckInTime(lastAttendance.value.timeCheckin);
    lastCheckOut.value = formatCheckInTime(lastAttendance.value.timeCheckout);
    lastDuration.value = calWorkingHour(
        lastAttendance.value.timeCheckin, lastAttendance.value.timeCheckout);
  }

  String formatCheckInTime(DateTime? time) {
    if (time == null) {
      return "--:--";
    }
    return DateFormat("HH:mm").format(time);
  }

  String calWorkingHour(DateTime? checkInTime, DateTime? checkOutTime) {
    if (checkInTime == null || checkOutTime == null) {
      return "--:--";
    } else {
      final Duration duration = checkOutTime.difference(checkInTime);
      return duration.inHours.toString();
    }
  }

  getDateNow() {
    DateTime now = DateTime.now();
    var locale = LanguageService.locales[
        Get.find<AuthService>().languageApp == null
            ? 0
            : (Get.find<AuthService>().languageApp! - 1)];
    initializeDateFormatting(locale.toString());
    String formattedDate =
        DateFormat('EEEE, MMMM dd', locale.toString()).format(now);
    date.value = formattedDate;
  }

  chooseTypeWorkCheckinWifi() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: Numeral.WIDTH_SCREEN * 0.7,
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Text(
                          "Choose type work",
                          style: TextStyle(
                              color: AppColor.primaryText,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          isTypeWorkWifi.value = Numeral.TYPE_WORK_AT_WORK;
                          await callApiGetListShift();
                          if (userInfo.value.shiftId != null) {
                            var result = await HomeProvider().checkIn(
                                userInfo.value.shiftId,
                                currentLocationLat.value,
                                currentLocationLong.value,
                                Numeral.TYPE_WORK_AT_WORK);

                            if (result) {
                              callApiLastCheckInProvider();
                            } else {
                              BaseDialog.getBaseDialog(
                                  context: Get.context!,
                                  title: "check_in_fail".tr,
                                  desc: "check_in_fail_desc".tr,
                                  dialogType: DialogType.error,
                                  buttonColor: AppColor.lightRed,
                                  textColor: AppColor.lightRed);
                            }
                            Get.back();
                            Get.back();
                          } else {
                            chooseShift(Numeral.TYPE_WORK_AT_WORK);
                          }
                        },
                        child: SizedBox(
                          width: Numeral.WIDTH_SCREEN * 0.3,
                          height: Numeral.WIDTH_SCREEN * 0.3,
                          child: SvgPicture.asset(
                              "assets/images/common/ic_at_work.svg"),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          isTypeWorkWifi.value = Numeral.TYPE_WORK_REMOTE;
                          await callApiGetListShift();
                          if (userInfo.value.companyInfo!.typeWork ==
                              Numeral.TYPE_WORK_AT_WORK) {
                            /// thông báo công ty chỉ cho làm tại công ty
                            Get.snackbar(
                                "noti".tr,
                                "noti_default_checkin".trParams({
                                  "typeCheckin": "location".tr,
                                }));
                          } else if (userInfo.value.companyInfo!.typeWork ==
                              Numeral.TYPE_WORK_AT_WORK_REMOTE) {
                            if (userInfo.value.shiftId == null) {
                              chooseShift(Numeral.TYPE_WORK_REMOTE);
                            } else {
                              var result = await HomeProvider().checkIn(
                                  userInfo.value.shiftId,
                                  currentLocationLat.value,
                                  currentLocationLong.value,
                                  Numeral.TYPE_WORK_REMOTE);

                              if (result) {
                                callApiLastCheckInProvider();
                              } else {
                                BaseDialog.getBaseDialog(
                                    context: Get.context!,
                                    title: "check_in_fail".tr,
                                    desc: "check_in_fail_desc".tr,
                                    dialogType: DialogType.error,
                                    buttonColor: AppColor.lightRed,
                                    textColor: AppColor.lightRed);
                              }
                              Get.back();
                              Get.back();
                            }
                          }
                        },
                        child: SizedBox(
                          width: Numeral.WIDTH_SCREEN * 0.3,
                          height: Numeral.WIDTH_SCREEN * 0.3,
                          child: SvgPicture.asset(
                              "assets/images/common/ic_remote.svg"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
