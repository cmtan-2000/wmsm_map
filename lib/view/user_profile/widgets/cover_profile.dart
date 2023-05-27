import 'package:flutter/material.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/profile_picture.dart';

class CoverContent extends StatelessWidget {
  const CoverContent(
      {super.key,
      required this.title,
      required this.content,
      required this.users});

  final String title;
  final Widget content;
  final Users users;
  //*user fullname and username
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Container(),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  )), //*title at app bar
        ),
        body: Stack(
          children: [
            //* Yellow part of container
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
                      child: ProfilePicture(users: users),
                    ),
                  ),
                ),
              ),
            ),

            //*White part of container
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.61,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    //*Give shadow for the white container
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      //!ProfileMenuWidget contents
                      child: content,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
