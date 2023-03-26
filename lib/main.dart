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
  // Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("One Signal's App ID here");

  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. 
  // We recommend removing the following code and instead using an In-App Message to prompt for notification permission.
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint("Accepted permission: $accepted");
  });

  // Mostra a notificação na tela (ptBR)
  // Shows the notification on the screen (en)
  setHandlerForNotifications();
}

void setHandlerForNotifications() {
  OneSignal.shared.setNotificationWillShowInForegroundHandler(_pushNotificationsHandler);
}

void _pushNotificationsHandler(OSNotificationReceivedEvent event) {
  event.complete(event.notification);
}
