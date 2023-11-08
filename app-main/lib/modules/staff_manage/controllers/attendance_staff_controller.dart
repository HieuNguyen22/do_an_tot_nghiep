import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/modules/staff_manage/models/attendance.dart';
import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:app_work_log/modules/staff_manage/provider/attendance_staff_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceStaffController extends GetxController {
  Rx<StaffManage> staff = StaffManage().obs;

  var dateGetLeaveRequest = Rx<DateTime>(DateTime.now());

  var checkFilterLeaveRequest = false.obs;
  var datesGetLeaveRequest = "".obs;

  RxString advancedTimeStart = "----/--/--".obs;
  RxString advancedTimeEnd = "----/--/--".obs;

  var listAttendanceFromUserId = <AttendanceModel>[AttendanceModel(id: -1)].obs;

  @override
  void onInit() {
    staff.value = Get.arguments;
    super.onInit();
    DateTime now = DateTime.now();
    advancedTimeStart.value = DateFormat("yyyy/MM/dd").format(now);
    advancedTimeEnd.value = DateFormat("yyyy/MM/dd").format(now);
    getAttendanceFromUserId();
  }

  resetList() {
    listAttendanceFromUserId.value = [AttendanceModel(id: -1)];
  }

  getAttendanceFromUserId() async {
    resetList();
    DateTime timeCheckinStart =
        DateFormat("yyyy/MM/dd").parse(advancedTimeStart.value);
    timeCheckinStart = DateTime(
        timeCheckinStart.year, timeCheckinStart.month, timeCheckinStart.day);

    DateTime timeCheckinEnd =
        DateFormat("yyyy/MM/dd").parse(advancedTimeEnd.value);

    if (advancedTimeStart.value == advancedTimeEnd.value) {}
    timeCheckinEnd = timeCheckinEnd.add(const Duration(days: 1));
    timeCheckinEnd =
        DateTime(timeCheckinEnd.year, timeCheckinEnd.month, timeCheckinEnd.day);

    listAttendanceFromUserId.value = await AttendanceStaffProvider()
        .getListCheckInOfStaff(timeCheckinStart, timeCheckinEnd,
            staff.value.companyId!, staff.value.id!);
  }

  nextDateLeaveRequest() async {
    resetList();
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value =
        dateGetLeaveRequest.value.add(const Duration(days: 1));

    DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year,
        dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);

    DateTime dateEnd = DateTime(
        dateGetLeaveRequest.value.add(const Duration(days: 1)).year,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).month,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).day);

    listAttendanceFromUserId.value = await AttendanceStaffProvider()
        .getListCheckInOfStaff(
            dateBegin, dateEnd, staff.value.companyId!, staff.value.id!);
  }

  backDateLeaveRequest() async {
    resetList();
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value =
        dateGetLeaveRequest.value.subtract(const Duration(days: 1));

    DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year,
        dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);

    DateTime dateEnd = DateTime(
        dateGetLeaveRequest.value.add(const Duration(days: 1)).year,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).month,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).day);

    listAttendanceFromUserId.value = await AttendanceStaffProvider()
        .getListCheckInOfStaff(
            dateBegin, dateEnd, staff.value.companyId!, staff.value.id!);
  }
}
