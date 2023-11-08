import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/languages/language_service.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/oauth2/service/notification_service.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importnce Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _message(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == "scheduledNotification") {
        tz.initializeTimeZones();
        tz.Location local = tz.local;
        NotificationService().scheduleNotification(
          id: inputData!['id'],
          title: inputData['title'],
          body: inputData['body'],
          scheduledNotificationDateTime: inputData['timeSchedule'],
        );
        return Future.value(true);
      }
      return Future.value(false);
    } catch (err) {
      throw Exception(err);
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationService().initNotification();
  if (!kIsWeb) {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((message) => _message(message));
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print(token);
    });
  }

  await dotenv.load(fileName: "lib/.env");
  await GetStorage.init();
  await Get.putAsync(() => AuthService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return FlutterWebFrame(
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        locale: LanguageService.locale,
        fallbackLocale: LanguageService.fallbackLocale,
        translations: LanguageService(),
        getPages: AppPages.routes,
      ),
      maximumSize: Size(
        Numeral.WIDTH_SCREEN,
        Get.height,
      ),
      enabled: kIsWeb,
      backgroundColor: Colors.black,
    );
  }
}
