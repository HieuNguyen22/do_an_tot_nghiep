import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  /// Storage.
  GetStorage boxStorage = GetStorage();

  /// Constant.
  static const keyToken = "KEY_TOKEN";
  static const keyRefreshToken = "KEY_REFRESH_TOKEN";
  static const keyId = "KEY_ID";
  static const keyLanguage = "KEY_LANGUAGE";
  static const keySaveInfoLogin = "KEY_SAVE_INFO_LOGIN";
  static const keyEmailLogin = "KEY_EMAIL_LOGIN";
  static const keyPasswordLogin = "KEY_PASSWORD_LOGIN";
  String? _token;
  String? _refreshToken;

  /// Status authentication.
  final authed = false.obs;

  Future<AuthService> init() async {
    token;
    return this;
  }

  /// Login with [token], [refreshToken] and [routeName].
  login({String? token, String? refreshToken, String? routeName, String? id}) {
    _token = token;
    _refreshToken = refreshToken;
    authed.value = token != null;

    /// Save token and refreshToken to local storage.
    boxStorage.write(keyToken, token);
    boxStorage.write(keyId, id);
    boxStorage.write(keyRefreshToken, refreshToken);

    /// Redirect page before when login.
    if (authed.value && routeName != null) Get.offAllNamed(routeName);
  }

  /// Register and Login with [token], [refreshToken] and [routeName].
  registerAndLogin(
      {String? token, String? refreshToken, String? routeName, String? id}) {
    _token = token;
    _refreshToken = refreshToken;
    authed.value = token != null;

    /// Save token and refreshToken to local storage.
    boxStorage.write(keyToken, token);
    boxStorage.write(keyId, id);
    boxStorage.write(keyRefreshToken, refreshToken);

    /// Redirect page before when login.
    if (authed.value && routeName != null) {
      Get.toNamed(routeName);
    }
  }

  /// Logout app
  logout() {
    /// Remove token and refreshToken from local storage.
    boxStorage.remove(keyToken);
    boxStorage.remove(keyRefreshToken);

    /// Reset value
    _token = null;
    _refreshToken = null;
    authed.value = false;

    /// Redirect page login.
    if (!authed.value) Get.offAllNamed(Routes.SPLASH);
  }

  /// Register
  logoutAndRegister() async {
    showLoading();
    await Future.delayed(const Duration(milliseconds: 1100));

    /// Remove token and refreshToken from local storage.
    boxStorage.remove(keyToken);
    boxStorage.remove(keyRefreshToken);

    /// Reset value
    _token = null;
    _refreshToken = null;
    authed.value = false;

    closeLoading();

    /// Redirect page REGISTER.
    if (!authed.value) Get.offAllNamed("Routes.REGISTER");
  }

  /// Get token from local storage.
  String? get token {
    _token ??= boxStorage.read(keyToken);
    authed.value = _token != null;
    return _token;
  }

  /// Get refreshToken from local storage.
  String? get refreshToken {
    _refreshToken ??= boxStorage.read(keyRefreshToken);
    authed.value = _refreshToken != null;

    return _refreshToken;
  }

  setLanguageServiceApp(int language) {
    boxStorage.write(keyLanguage, language);
  }

  int? get languageApp {
    return boxStorage.read(keyLanguage);
  }

  setSaveInfoLogin(bool status) {
    boxStorage.write(keySaveInfoLogin, status);
  }

  bool? get saveInfoLogin {
    return boxStorage.read(keySaveInfoLogin);
  }

  setEmailLogin(String email) {
    boxStorage.write(keyEmailLogin, email);
  }

  String? get emailLogin {
    return boxStorage.read(keyEmailLogin);
  }

  setPasswordLogin(String password) {
    boxStorage.write(keyPasswordLogin, password);
  }

  String? get passwordLogin {
    return boxStorage.read(keyPasswordLogin);
  }

  clearInfoLogin(){
    boxStorage.remove(keyEmailLogin);
    boxStorage.remove(keyPasswordLogin);
  }
}
