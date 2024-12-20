

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import '../../../feature/reminder/models/task.dart';
import '../../../feature/reminder/presention/pages/alarm_page.dart';
import '../../task_db_controllers/task.controller.dart';

//import '../db/db.helper.dart';


final _taskController = Get.put(TaskController());
class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    await _configureLocalTimezone();

    // Android Initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    // For on tap onSelectNotification
    Future<void> onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) async {
      // Display a dialog with the notification details
      Get.dialog(
        AlertDialog(
          title: Text(title ?? 'تيسير'),
          content: Text(body ?? 'مرحباً بك في تطبيق تيسير'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
                // You can navigate to another screen here if needed
                // Get.to(() => SecondScreen(payload));
              },
              child: const Text('حسنا'),
            ),
          ],
        ),
      );
    }

    // For on tap onSelectNotification
    Future<void> selectNotification(String? payload) async {
      if (payload == "Theme Changed"||payload == "يجب إعادة شراء شريط حبوب") {
        //going nowhere
        // Get.to(() => NotificationDetailPage(
        //       label: payload,
        //     ));
      } else {
        List<String> taskDetails=payload!.split(',');
        if(taskDetails[1]=="حبوب"){
          if(int.parse(taskDetails[3])>0){
            taskDetails[3]=(int.parse(taskDetails[3])-int.parse(taskDetails[2])).toString();
            await _taskController.updateNumberOfStripPills(int.parse(taskDetails[0]),int.parse(taskDetails[3]));

            if(int.parse(taskDetails[3])<=0){
              displayNotification(
                  title: "يجب إعادة شراء شريط حبوب",
                  body: "لديك موعد دواء حبوب"
                      "اسم الموعد: ${taskDetails[4]}");
            }
          }
        }
        Get.to(() =>AlarmPage()); /*NotificationDetailPage(
              label: "${payload!.split(',')[4]} | ${taskDetails[5]} | ${taskDetails[6]}",
            ));*/
      }
    }

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  // Request Permissions for iOS
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

// Request Permissions for Android
  Future<void> requestAndroidPermissions() async {
    // Request the required permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
      Permission.scheduleExactAlarm,
      // Add other permissions as needed
    ].request();

    // Check if the permissions are granted
    if (statuses[Permission.notification] == PermissionStatus.granted &&
        statuses[Permission.scheduleExactAlarm] == PermissionStatus.granted) {
    } else {
      Get.snackbar("Permission Denied",
          "Please allow Notification permission from settings",
          backgroundColor: Colors.redAccent, colorText: Colors.white);

      // If permissions are denied, we cannot continue the app
      await [
        Permission.notification,
        Permission.scheduleExactAlarm,
      ].request();
    }
  }

  Future<bool> requestScheduleExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      return true;
    } else {
      await Permission.scheduleExactAlarm.isDenied.then((value) {
        if (value) {
          Permission.scheduleExactAlarm.request();
        }
      });
      return false;
    }
  }

  // Immediate Notification
  Future<void> displayNotification(
      {required String title, required String body ,required}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
      icon: 'app_icon',
      sound: RawResourceAndroidNotificationSound('sound'),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),


    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: "$title | $body |",
    );
  }

  //  Scheduled Notification
  Future<void> scheduledNotification(int hour, int minutes, Task task,) async {
   // updateTask=task;

    // Future<void> scheduledNotification(int hour, int minutes, Task task) async {
    String msg;
    msg = "لقد حان موعد المهمة التالية:";

    tz.TZDateTime scheduledDate = await _convertTime(hour, minutes);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
      "عنوان الموعد: ${task.title}",
      task.note,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          icon: 'app_icon',
          sound: const RawResourceAndroidNotificationSound('sound'),
          // largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
          subText: msg,




        ),
      ),

      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,

      payload: "${task.id},${task.medicineType},${task.numberOfPills},${task.numberOfStripPills},${task.title},${task.note},${task.startTime}",


    );
  }
  Future<void> scheduledNotification2(int hour, int minutes, Task task,) async {
   // updateTask=task;
    // Future<void> scheduledNotification(int hour, int minutes, Task task) async {
    String msg;
    msg = "لقد حان موعد المهمة التالية:";

    tz.TZDateTime scheduledDate = await _convertTime(hour, minutes);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt()+100,
      "عنوان الموعد: ${task.title}",
      task.note,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          icon: 'app_icon',
          sound: const RawResourceAndroidNotificationSound('sound'),
          // largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
          subText: msg,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${task.id},${task.medicineType},${task.numberOfPills},${task.numberOfStripPills},${task.title},${task.note},${task.startTime2}",
    );
  }
  Future<void> scheduledNotification3(int hour, int minutes, Task task,) async {
    //updateTask=task;
    // Future<void> scheduledNotification(int hour, int minutes, Task task) async {
    String msg;
    msg = "لقد حان موعد المهمة التالية:";

    tz.TZDateTime scheduledDate = await _convertTime(hour, minutes);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt()+200,
      "عنوان الموعد: ${task.title}",
      task.note,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          icon: 'app_icon',
          sound: const RawResourceAndroidNotificationSound('sound'),
          // largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
          subText: msg,

        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${task.id},${task.medicineType},${task.numberOfPills},${task.numberOfStripPills},${task.title},${task.note},${task.startTime3}",
    );
  }

  Future<void> remindNotification(int hour, int minutes, Task task,) async {
    tz.TZDateTime scheduledDate = await _convertTime(hour, minutes);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt() + 300,
      "لا تنسى اكمال مهمتك التالية:",
      "الساعة: ${task.startTime}عنوان الموعد: ${task.title}",
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          icon: 'app_icon',
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
          subText: "⏰ ${task.remind} minute's remaining",


        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  Future<void> remindNotification2(int hour, int minutes, Task task,) async {
    tz.TZDateTime scheduledDate = await _convertTime(hour, minutes);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt() + 400,
"لا تنسى اكمال مهمتك التالية:",
"الساعة: ${task.startTime2}عنوان الموعد: ${task.title}",
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          icon: 'app_icon',
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
          subText: "⏰ ${task.remind} minute's remaining",
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  Future<void> remindNotification3(int hour, int minutes, Task task,) async {
    tz.TZDateTime scheduledDate = await _convertTime(hour, minutes);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt() + 500,
"لا تنسى اكمال مهمتك التالية:",
"الساعة: ${task.startTime3}عنوان الموعد: ${task.title}",
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          icon: 'app_icon',
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
          subText: "⏰ ${task.remind} minute's remaining",
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<tz.TZDateTime> _convertTime(int hour, int minutes) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    try {
      tz.setLocalLocation(tz.getLocation(timeZone));
    } catch (e) {
      // If the location is not found, set a default location
      tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));
    }
  }
}
