import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motolocation/constants/color.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
      ),
      body: Column(
        children: _buildNotificationList(),
      ),
    );
  }

  List<Widget> _buildNotificationList() {
    final notifications = [
      {
        'title': 'Bildirim 1',
        'subtitle': 'Bildirim 1 açıklaması',
        'date': '2021-10-01',
        'notificationType': 'info'
      },
      {
        'title': 'Bildirim 2',
        'subtitle': 'Bildirim 2 açıklaması',
        'date': '2021-10-02',
        'notificationType': 'warning'
      },
      {
        'title': 'Bildirim 3',
        'subtitle': 'Bildirim 3 açıklaması',
        'date': '2021-10-03',
        'notificationType': 'error'
      },
      {
        'title': 'Bildirim 4',
        'subtitle': 'Bildirim 4 açıklaması',
        'date': '2021-10-04',
        'notificationType': 'info'
      },
      {
        'title': 'Bildirim 5',
        'subtitle': 'Bildirim 5 açıklaması',
        'date': '2021-10-05',
        'notificationType': 'warning'
      },
    ];

    return notifications.map((notification) {
      return ListTile(
        title: Text(notification['title']!),
        subtitle: Text(notification['subtitle']!),
        leading: Icon(
            _getIconForNotification(notification['notificationType']!),
            color: HexColor(primaryColor)),
        onTap: () {},
      );
    }).toList();
  }

  IconData _getIconForNotification(String notificationType) {
    switch (notificationType) {
      case 'info':
        return Icons.info;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      default:
        return Icons.notifications; // Varsayılan ikon
    }
  }
}
