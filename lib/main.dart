import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();
  initializeOneSignalPushNotifications();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void initializeOneSignalPushNotifications() {
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("dd2400ec-852c-494a-9c47-7e5c489907d9");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint("Accepted permission: $accepted");
  });

  //1 - MOSTRA A NOTIFICAÇÃO NA TELA
  setHandlerForNotifications();
}

void setHandlerForNotifications() {
  OneSignal.shared.setNotificationWillShowInForegroundHandler(_handler);
}

void _handler(OSNotificationReceivedEvent event) {
  event.complete(event.notification);
}
