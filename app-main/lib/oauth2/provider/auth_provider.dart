// File login_provider

import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/oauth2/model/register.dart';
import 'package:app_work_log/oauth2/model/register_company.dart';

abstract class IAuthService {
  /// Login with [userAccount] and [password].
  Future loginOnApp(String? userAccount, String? password);

  /// Register with [register].
  Future registerOnTheApp(Register? register);

  /// Login UserGuest with [deviceId].
  Future createdUserGuest(String? deviceId);

  /// Refresh token.
  Future refreshToken(String? refreshToken);
}

class AuthProvider extends ServiceProvider implements IAuthService {
  AuthProvider({provider}) : super(provider: provider ?? apiPublishProvider);

  /// Login with [userAccount] and [password].
  @override
  Future loginOnApp(String? email, String? password) {
    return getData(
      provider.post(ApiUrl.LOGIN, data: {"email": email, "password": password}),
    );
  }

  /// Register with [register].
  @override
  Future registerCompany(RegisterCompany? company) {
    return getData(
      provider.post(ApiUrl.REGISTER_COMPANY, data: company?.toJson()
      ),
    );
  }

  /// Register with [register].
  @override
  Future registerOnTheApp(Register? register) {
    return getData(
      provider.post("/auth/register", data: register?.toJson()),
    );
  }

  /// Login UserGuest with [deviceId].
  @override
  Future createdUserGuest(String? deviceId) {
    return getData(
      provider.post("/Authenticate/CreatedUserGuest",
          queryParameters: {"deviceId": deviceId}),
    );
  }

  /// Refresh token [refreshToken].
  @override
  Future refreshToken(String? refreshToken) {
    return getData(
      // provider.post(ApiUrl.REFRESH_TOKEN,
      //     data: {"data": refreshToken}),
      provider.get(ApiUrl.REFRESH_TOKEN,),
    );
  }

  @override
  Future forgotPassword(String? email) {
    return getData(
      provider.post(ApiUrl.FORGOT_PASSWORD, data: {"email": email}),
    );
  }
}
