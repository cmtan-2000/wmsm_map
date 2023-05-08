import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/model/users.dart';

class CoverContent extends StatelessWidget {
  const CoverContent(
      {super.key,
      required this.title,
      required this.content,
      required this.user});

  final String title;
  final Widget content;
  final Users user; //*user fullname and username

  // void _navigateToNextScreen(BuildContext context) {
  //   Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => const EditProfilePicture()));
  // }

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
                                    showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoActionSheet(
                                            actions: <
                                                CupertinoActionSheetAction>[
                                              CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  //TODO: Take photo
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Take Photo',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  //TODO: Choose from gallery
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Choose from Gallery',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              //*Cancel option
                                              CupertinoActionSheetAction(
                                                isDestructiveAction: true,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                            ],
                                          );
                                        });
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
    );
  }
}
