import 'package:flutter/material.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/profile_picture.dart';

class CoverInfo extends StatelessWidget {
  const CoverInfo(
      {super.key,
      required this.title,
      required this.content,
      required this.users});

  final String title;
  final Widget content;
  final Users users; //*user weight, height

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(title,
              style: Theme.of(context).textTheme.bodyLarge), //*title at app bar
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
                          ProfilePicture(users: users),
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
                  const SizedBox(
                    height: 10,
                  ),
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
