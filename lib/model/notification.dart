class NotificationCard {
  final String notifTitle;
  final String notifDate;
  final String notifImg;

  NotificationCard(
      {required this.notifTitle,
      required this.notifDate,
      required this.notifImg});
}

NotificationCard notif1 = NotificationCard(
    notifTitle: 'Challenge: New challenge released!',
    notifDate: '17/5/2023',
    notifImg: 'assets/images/notif1.png');

NotificationCard notif2 = NotificationCard(
    notifTitle: 'Reward: Claim your reward now!',
    notifDate: '17/5/2023',
    notifImg: 'assets/images/notif2.png');

NotificationCard notif3 = NotificationCard(
    notifTitle: 'Article: New article released!',
    notifDate: '17/5/2023',
    notifImg: 'assets/images/notif3.png');
