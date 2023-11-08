import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/languages/language_service.dart';
import 'package:app_work_log/modules/manage/models/manage.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:get/get.dart';

class ManageController extends GetxController {
  var listManage = <Manage>[].obs;

  @override
  void onInit() {
    super.onInit();
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
  }

  getManage() {
    if (Global.roleCodeUser == Numeral.ROLE_CODE_ADMIN) {
      listManage.value = [
        Manage(icon: "ic_attendance_checkin.svg", color: AppColor.colorCardAttendanceCheckIn, text: "attendance_checkin".tr),
        Manage(icon: "ic_attendance_late.svg", color: AppColor.colorCardAttendanceLate, text: "attendance_late".tr),
        Manage(icon: "ic_attendance_casual_leave.svg", color: AppColor.colorCardAttendanceCasualLeave, text: "attendance_casual_leave".tr),
        Manage(icon: "ic_dashboard_statistics.svg", color: AppColor.colorCardDashboardStatistics, text: "dashboard_statistics".tr),
        Manage(icon: "ic_leave_request.svg", color: AppColor.colorCardLeaveRequests, text: "leave_requests".tr),
        Manage(icon: "ic_overtime_requests.svg", color: AppColor.colorCardOvertimeRequests, text: "overtime_requests".tr),
        Manage(icon: "ic_staff.svg", color: AppColor.colorCardManageStaff, text: "staff_manage".tr),
        Manage(icon: "ic_department.svg", color: AppColor.colorCardManageDepartment, text: "department_manage".tr),
        Manage(icon: "ic_shift.svg", color: AppColor.colorCardManageShift, text: "shift_manage".tr),
        Manage(icon: "ic_profile_company.svg", color: AppColor.colorCardProfileCompany, text: "profile_company".tr),
        Manage(icon: "ic_company_setting.svg", color: AppColor.colorCardCompanySettings, text: "company_settings".tr),
      ];
    } else if (Global.roleCodeUser == Numeral.ROLE_CODE_MANAGER) {
      listManage.value = [
        Manage(icon: "ic_attendance_checkin.svg", color: AppColor.colorCardAttendanceCheckIn, text: "attendance_checkin".tr),
        Manage(icon: "ic_attendance_late.svg", color: AppColor.colorCardAttendanceLate, text: "attendance_late".tr),
        Manage(icon: "ic_attendance_casual_leave.svg", color: AppColor.colorCardAttendanceCasualLeave, text: "attendance_casual_leave".tr),
        Manage(icon: "ic_dashboard_statistics.svg", color: AppColor.colorCardDashboardStatistics, text: "dashboard_statistics".tr),
        Manage(icon: "ic_leave_request.svg", color: AppColor.colorCardLeaveRequests, text: "leave_requests".tr),
        Manage(icon: "ic_overtime_requests.svg", color: AppColor.colorCardOvertimeRequests, text: "overtime_requests".tr),
      ];
    }
  }
}
