import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_templete/core/data/models/notification_model.dart';
import 'package:flutter_templete/core/enums/app_state_enum.dart';
import 'package:flutter_templete/core/utils/general_utils.dart';
import 'package:get/utils.dart';

class NotificationService {
  StreamController<NotificationModel> notifcationStream =
      StreamController<NotificationModel>.broadcast();

  NotificationService() {
    onInit();
  }

  void onInit() async {
    if (GetPlatform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await registerdFCMToken();
      } else {
        return;
      }
    } else {
      await registerdFCMToken();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationModel model = NotificationModel.fromJson(message.data);
      handelNotification(model: model, appState: AppState.FOREGROUND);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      NotificationModel model = NotificationModel.fromJson(message.data);
      handelNotification(model: model, appState: AppState.BACKGROUND);
    });
  }

  Future<void> registerdFCMToken() async {
    final fcmToken;
    if (storage.getFcmToken() == '') {
      fcmToken = await FirebaseMessaging.instance.getToken();
      storage.setFcmToken(fcmToken);
    } else {
      fcmToken = storage.getFcmToken();
    }
    //! -- Call api that register fcm token ---
    print(storage.getFcmToken());

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      //! -- Call api that register fcm token ---

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
  }

  void handelNotification(
      {required NotificationModel model, required AppState appState}) {
    notifcationStream.add(model);
    // if (model.notifctionType == NotificationType.SUBSCRIPTION.name) {
    // storage.setSubStatus(model.subStatus == "1" ? true : false);
    // }
  }
}
