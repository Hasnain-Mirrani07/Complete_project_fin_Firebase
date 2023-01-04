import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(1);
}

Future<void> createNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_chanel_key',
          title: '${Icon(Icons.attach_money_rounded)} Channel Noiti',
          body: 'body of notifi',
          bigPicture: 'asset://assets/notification_pic.png',
          notificationLayout: NotificationLayout.BigPicture));
}
