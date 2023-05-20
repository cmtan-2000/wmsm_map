import 'package:flutter/material.dart';
import 'package:wmsm_flutter/model/notification.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  List<NotificationCard> notifList = [notif1, notif2, notif3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          title: Text('Notification',
              style: Theme.of(context).textTheme.bodyLarge),
          automaticallyImplyLeading: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    itemCount: notifList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            foregroundImage:
                                AssetImage(notifList[index].notifImg),
                            backgroundColor: Colors.transparent,
                            radius: 25,
                          ),
                          title: Text(notifList[index].notifTitle),
                          subtitle: Text(notifList[index].notifDate,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.teal)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
