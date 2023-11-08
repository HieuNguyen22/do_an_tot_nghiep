import 'package:app_work_log/modules/account/bindings/account_binding.dart';
import 'package:app_work_log/modules/account/bindings/change_password_binding.dart';
import 'package:app_work_log/modules/account/bindings/default_checkin_binding.dart';
import 'package:app_work_log/modules/account/bindings/default_shift_binding.dart';
import 'package:app_work_log/modules/account/bindings/language_binding.dart';
import 'package:app_work_log/modules/account/bindings/leave_request_history_binding.dart';
import 'package:app_work_log/modules/account/bindings/overtime_request_history_binding.dart';
import 'package:app_work_log/modules/account/bindings/update_profile_binding.dart';
import 'package:app_work_log/modules/account/views/change_password_view.dart';
import 'package:app_work_log/modules/account/views/default_checkin_view.dart';
import 'package:app_work_log/modules/account/views/default_shift_view.dart';
import 'package:app_work_log/modules/account/views/language_view.dart';
import 'package:app_work_log/modules/account/views/leave_request_history_view.dart';
import 'package:app_work_log/modules/account/views/overtime_request_history_view.dart';
import 'package:app_work_log/modules/account/views/update_profile_view.dart';
import 'package:app_work_log/modules/attendance/bindings/attendance_binding.dart';
import 'package:app_work_log/modules/attendance_manage/bindings/attendance_manage_binding.dart';
import 'package:app_work_log/modules/attendance_manage/views/attendance_manage_view.dart';
import 'package:app_work_log/modules/company_profile/bindings/company_profile_binding.dart';
import 'package:app_work_log/modules/company_profile/views/company_profile_view.dart';
import 'package:app_work_log/modules/company_setting/bindings/company_setting_binding.dart';
import 'package:app_work_log/modules/company_setting/views/company_setting_view.dart';
import 'package:app_work_log/modules/company_setting/views/location_company_view.dart';
import 'package:app_work_log/modules/dashboard_statistics/bindings/dashboard_statistics_binding.dart';
import 'package:app_work_log/modules/dashboard_statistics/views/dashboard_statistics_view.dart';
import 'package:app_work_log/modules/department_manage/bindings/department_manage_binding.dart';
import 'package:app_work_log/modules/department_manage/views/department_manage_view.dart';
import 'package:app_work_log/modules/enroll_company/bindings/enroll_company_binding.dart';
import 'package:app_work_log/modules/enroll_company/views/enroll_success_view.dart';
import 'package:app_work_log/modules/enroll_company/views/get_location_view.dart';
import 'package:app_work_log/modules/leave_request/bindings/leave_request_binding.dart';
import 'package:app_work_log/modules/leave_request/views/leave_request_view.dart';
import 'package:app_work_log/modules/leave_request_manage/bindings/leave_request_manage_binding.dart';
import 'package:app_work_log/modules/leave_request_manage/views/leave_request_manage_view.dart';
import 'package:app_work_log/modules/login/bindings/forgot_password_binding.dart';
import 'package:app_work_log/modules/login/views/forgot_password_view.dart';
import 'package:app_work_log/modules/manage/bindings/manage_binding.dart';
import 'package:app_work_log/modules/notification/bindings/notification_binding.dart';
import 'package:app_work_log/modules/enroll_company/views/set_up_company_view.dart';
import 'package:app_work_log/modules/home/bindings/home_binding.dart';
import 'package:app_work_log/modules/home/views/home.dart';
import 'package:app_work_log/modules/login/bindings/login_biding.dart';
import 'package:app_work_log/modules/enroll_company/views/enroll_company_view.dart';
import 'package:app_work_log/modules/enroll_company/views/intro_view.dart';
import 'package:app_work_log/modules/login/views/login_view.dart';
import 'package:app_work_log/modules/enroll_company/views/splash_screen.dart';
import 'package:app_work_log/modules/overtime_request/bindings/overtime_request_binding.dart';
import 'package:app_work_log/modules/overtime_request/views/overtime_request_view.dart';
import 'package:app_work_log/modules/overtime_request_manage/bindings/overtime_request_manage_binding.dart';
import 'package:app_work_log/modules/overtime_request_manage/views/overtime_request_manage_view.dart';
import 'package:app_work_log/modules/service/bindings/service_binding.dart';
import 'package:app_work_log/modules/service/views/service_detail.dart';
import 'package:app_work_log/modules/service/views/service_view.dart';
import 'package:app_work_log/modules/shift_manage/bindings/shift_manage_binding.dart';
import 'package:app_work_log/modules/shift_manage/views/shift_manage_view.dart';
import 'package:app_work_log/modules/sign_up/bindings/sign_up_staff_binding.dart';
import 'package:app_work_log/modules/sign_up/views/create_staff_view.dart';
import 'package:app_work_log/modules/sign_up/views/sign_up_staff_view.dart';
import 'package:app_work_log/modules/staff_manage/bindings/attendance_staff_binding.dart';
import 'package:app_work_log/modules/staff_manage/bindings/profile_staff_binding.dart';
import 'package:app_work_log/modules/staff_manage/bindings/staff_manage_binding.dart';
import 'package:app_work_log/modules/staff_manage/bindings/workingh_statistics_staff_binding.dart';
import 'package:app_work_log/modules/staff_manage/views/attendance_staff_view.dart';
import 'package:app_work_log/modules/staff_manage/views/profile_staff_view.dart';
import 'package:app_work_log/modules/staff_manage/views/staff_manage_view.dart';
import 'package:app_work_log/modules/staff_manage/views/workingh_statistics_staff_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
        name: "/",
        page: () => const SplashView(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.INTRO,
        page: () => const IntroView(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ENROLL_COMPANY,
        page: () => EnrollCompanyView(),
        bindings: [EnrollCompanyBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.SETUP_COMPANY,
        page: () => SetUpCompanyView(),
        bindings: [EnrollCompanyBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.GET_LOCATION,
        page: () => GetLocationView(),
        bindings: [EnrollCompanyBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ENROLL_SUCCESS,
        page: () => EnrollSuccessView(),
        bindings: [EnrollCompanyBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.SIGN_UP,
        page: () => SignUpStaffView(),
        bindings: [SignUpStaffBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.CREATE_STAFF,
        page: () => CreateStaffView(),
        bindings: [SignUpStaffBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        bindings: [LoginBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.HOME,
        page: () => const Home(),
        bindings: [
          HomeBinding(),
          AttendanceBinding(),
          ManageBinding(),
          NotificationBinding(),
          AccountBinding(),
        ],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.LEAVE_REQUEST,
        page: () => LeaveRequestView(),
        bindings: [
          LeaveRequestBinding(),
        ],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.OVERTIME_REQUEST,
        page: () => OvertimeRequestView(),
        bindings: [
          OvertimeRequestBinding(),
        ],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.SERVICE,
        page: () => const ServiceView(),
        bindings: [ServiceBinding()],
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.SERVICE_DETAIL,
        bindings: [ServiceBinding()],
        page: () => const ServiceDetail(),
        transition: Transition.leftToRight),
    GetPage(
      name: _Paths.ATTENDANCE_MANAGE,
      page: () => const AttendanceManageView(),
      bindings: [AttendanceManageBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STAFF_MANAGE,
      page: () => const StaffManageView(),
      bindings: [StaffManageBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE_STAFF,
      page: () => const ProfileStaffManageView(),
      bindings: [ProfileStaffBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.WORKING_HOURS_STATISTICS,
      page: () => const WorkingHoursStatisticsStaffView(),
      bindings: [WorkingHoursStatisticsStaffBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ATTENDANCE_STAFF,
      page: () => const AttendanceStaffView(),
      bindings: [AttendanceStaffBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DEPARTMENT_MANAGE,
      page: () => const DepartmentManageView(),
      bindings: [DepartmentManageBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SHIFT_MANAGE,
      page: () => const ShiftManageView(),
      bindings: [ShiftManageBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DASHBOARD_STATISTICS,
      page: () => const DashboardStatisticsView(),
      bindings: [DashboardStatisticsBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.COMPANY_PROFILE,
      page: () => const CompanyProfileView(),
      bindings: [CompanyProfileBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LEAVE_REQUESTS_MANAGE,
      page: () => const LeaveRequestManageView(),
      bindings: [LeaveRequestManageBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.OVERTIME_REQUESTS_MANAGE,
      page: () => const OverTimeRequestManageView(),
      bindings: [OverTimeRequestManageBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      bindings: [UpdateProfileBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      bindings: [ChangePasswordBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LEAVE_REQUEST_HISTORY,
      page: () => const LeaveRequestHistoryView(),
      bindings: [LeaveRequestHistoryBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.OVERTIME_REQUEST_HISTORY,
      page: () => const OverTimeRequestHistoryView(),
      bindings: [OvertimeRequestHistoryBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.COMPANY_SETTING,
      page: () => const CompanySettingView(),
      bindings: [CompanySettingBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.COMPANY_LOCATION,
      page: () => const LocationCompanyView(),
      bindings: [CompanySettingBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => LanguageView(),
      bindings: [LanguageBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DEFAULT_SHIFT,
      page: () => const DefaultShiftView(),
      bindings: [DefaultShiftBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DEFAULT_CHECKIN,
      page: () => const DefaultCheckinView(),
      bindings: [DefaultCheckinBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      bindings: [ForgotPasswordBinding()],
      transition: Transition.fadeIn,
    ),
  ];
}
