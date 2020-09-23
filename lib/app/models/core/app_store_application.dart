import 'package:fluro/fluro.dart';

import 'package:flutter_starter_kit/app/models/api/auth_provider.dart';
import 'package:flutter_starter_kit/app/models/api/with_jwt_provider.dart';
import 'package:flutter_starter_kit/config/env.dart';
import 'package:flutter_starter_kit/utility/framework/application.dart';
import 'package:flutter_starter_kit/utility/helper/shared_pref_helper.dart';
import 'package:flutter_starter_kit/utility/log/log.dart';
import 'package:logging/logging.dart';

import 'app_routes.dart';

class AppStoreApplication implements Application {
  Router router;

//  FirebaseMessaging firebaseMessaging;
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  SharedPrefHelper sharedPrefHelper;

  AuthProvider authProvider;
  WithJwtProvider withJwtProvider;

//  DatabaseHelper _db;
//  DBAppStoreRepository dbAppStoreRepository;
//  AppStoreAPIRepository appStoreAPIRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    _initRouter();
    await _initSharedPref();
    // await _initLocalNotification();
    // await _initFirebase();

    _initProviders();

//    await _initDB();
//    _initDBRepository();
//    _initAPIRepository();
  }

  @override
  Future<void> onTerminate() async {
//    await _db.close();
  }

  Future<void> _initSharedPref() async {
    sharedPrefHelper = await SharedPrefHelper().init();
  }

  void _initProviders() {
    this.authProvider = AuthProvider();
    this.withJwtProvider = WithJwtProvider(this.sharedPrefHelper);
  }

//  Future<void> _initDB() async {
//    AppDatabaseMigrationListener migrationListener = AppDatabaseMigrationListener();
//    DatabaseConfig databaseConfig = DatabaseConfig(Env.value.dbVersion, Env.value.dbName, migrationListener);
//    _db = DatabaseHelper(databaseConfig);
//    Log.info('DB name : ' + Env.value.dbName);

// //    await _db.deleteDB();
//    await _db.open();
//  }

//  void _initDBRepository() {
//    dbAppStoreRepository = DBAppStoreRepository(_db.database);
//  }

//  void _initAPIRepository() {
//    APIProvider apiProvider = APIProvider();
//    appStoreAPIRepository = AppStoreAPIRepository(apiProvider, dbAppStoreRepository);
//  }

  /*
  // local notification
  Future<void> _initLocalNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
// */

  /*
  // firebase notification
  Future<void> _initFirebase() async {
    firebaseMessaging = FirebaseMessaging();

    // set device id token
    if (sharedPrefHelper.firebaseDeviceId == null) {
      final token = await firebaseMessaging.getToken();
      await sharedPrefHelper.setFirebaseDeviceId(token);
    }

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("firebase onMessage: $message");

        final notification = message['notification'];

        await showNotification(
          notification['title'],
          notification['body'],
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("firebase onLaunch: $message");
//        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("firebase onResume: $message");
//        _navigateToItemDetail(message);
      },
    );

    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );

    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

//   */

  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.TESTING:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:
        {
          Log.setLevel(Level.ALL);
          break;
        }
      case EnvType.PRODUCTION:
        {
          Log.setLevel(Level.INFO);
          break;
        }
    }
  }

  void _initRouter() {
    router = new Router();
    AppRoutes.configureRoutes(router);
  }

/*
  // Firebase Notification
  Future<void> showNotification(String title, String body) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'general',
      'General',
      'General Notification',
      importance: Importance.Default,
      priority: Priority.Default,
      ticker: 'ticker',
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

//    final int notificationId = DateTime.now().millisecondsSinceEpoch;
    final int notificationId = Random().nextInt(100);

    await flutterLocalNotificationsPlugin.show(
        notificationId, title, body, platformChannelSpecifics);
  }
// */

}
