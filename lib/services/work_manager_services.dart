import 'package:shopora_e_commerce/services/notifications_services.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerServices {
  WorkManagerServices._();
  static final WorkManagerServices instance = WorkManagerServices._();

  Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerOneOffTask(
      "welcome-notification",
      "welcome-notification",
      initialDelay: Duration(seconds: 10),
    );
    await Workmanager().registerPeriodicTask(
      "new-item",
      "new-item",
      frequency: Duration(minutes: 1),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "welcome-notification":
        await NotificationsServices.instance.showBasicNotification(
          1,
          "Hello,user",
          "lets go shopping...",
        );
        break;
      case "new-item":
        await NotificationsServices.instance.showBasicNotification(0, "New Item Available 🔥", "Check it out");
        break;

      default:
        // Handle unknown task types
        break;
    }

    return Future.value(true);
  });
}
