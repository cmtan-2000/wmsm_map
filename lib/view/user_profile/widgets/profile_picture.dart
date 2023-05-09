import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/model/users.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, required this.users});
  final Users users;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  //*User choose img from gallery or photo
  String defaultImgUrl =
      "https://i1.sndcdn.com/avatars-000307598863-zfe44f-t500x500.jpg"; //default image
  String imageUrl = '', username = '', fullname = '';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future pickImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    // print(image!.path);
    if (image == null) return;

    Reference refRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = refRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(image.path);

    try {
      //*Store the file
      await referenceImageToUpload.putFile(File(image.path));

      //*Get the URL of the file
      imageUrl = await referenceImageToUpload.getDownloadURL();

      db
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
            "profile_picture": imageUrl,
          })
          .then((_) => print('success!'))
          .catchError((error) => print('Failed to add user: $error'));

      print('current user: ${FirebaseAuth.instance.currentUser!.uid}');
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    username = widget.users.username;
    fullname = widget.users.fullname;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            // imageUrl = snapshot.data!.data()!['profile_picture'];
            username = snapshot.data!.data()!['username'];
            fullname = snapshot.data!.data()!['fullname'];

            return Column(
              children: [
                Stack(
                  children: [
                    //*Edit Profile Picture
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.data()?['profile_picture'] ??
                              defaultImgUrl,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: ((context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
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
                            //*Pressed then edit profile picture
                            onPressed: () {
                              showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoActionSheet(
                                      actions: <CupertinoActionSheetAction>[
                                        CupertinoActionSheetAction(
                                          isDefaultAction: true,
                                          onPressed: () {
                                            //*Take photo
                                            pickImage(ImageSource.camera);
                                            //*store URL into user's datbase

                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Take Photo',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                        CupertinoActionSheetAction(
                                          isDefaultAction: true,
                                          onPressed: () {
                                            //*Choose photo from gallery
                                            pickImage(ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Choose from Gallery',
                                            style:
                                                TextStyle(color: Colors.blue),
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
                  ],
                ),
                const SizedBox(height: 10),
                //*Name
                Text(fullname, style: Theme.of(context).textTheme.displaySmall),
                //*Username
                Text(
                  '@$username',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            );
          }
          return const Text('Error');
        });
  }
}
