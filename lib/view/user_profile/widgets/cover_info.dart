import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/model/users.dart';

class CoverInfo extends StatelessWidget {
  const CoverInfo(
      {super.key,
      required this.title,
      required this.content,
      required this.user});

  final String title;
  final Widget content;
  final Users user; //*user weight, height

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  )), //*title at app bar
        ),
        body: Stack(
          //* Yellow part of container
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  child: Container(
                    //*background colour of container
                    color: Theme.of(context).primaryColor,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Stack(children: [
                            //TODO: Edit Profile Picture
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipOval(
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset('assets/images/profile.png'),
                              ),
                            ),

                            //*Edit button UI, beside profile picture
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                width: 37,
                                height: 37,
                                child: Container(
                                  alignment: Alignment.center,
                                  //*for the black circle
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  //*edit icon
                                  child: IconButton(
                                    tooltip: 'Edit Profile',
                                    icon: const Icon(
                                      LineAwesomeIcons.pen,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    //*Press d then edit profile picture
                                    onPressed: () {
                                      print('Edit profile picture');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 10),
                          //*Name
                          Text(user.fullname,
                              style: Theme.of(context).textTheme.displaySmall),
                          //*Username
                          Text(
                            '@${user.username}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //*Card UI
            Positioned(
              top: MediaQuery.of(context).size.height * 0.20,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Card(
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                        child: content,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
