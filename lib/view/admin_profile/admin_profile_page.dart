import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/admin_profile/admin_profile_pic.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/profile_menu_widget.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String phoneNumber, email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7B01),
        elevation: 0,
        title: Text('Profile',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                )), //*title at app bar
      ),
      body: Stack(
        children: [
          //* Orange part of container
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
                  color: const Color(0xFFFF7B01),
                  child: const Align(
                    alignment: Alignment.topCenter,
                    //!Admin profile picture
                    child: AdminProfilePicture(),
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
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: StreamBuilder(
                              stream: db
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError ||
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasData) {
                                  phoneNumber = snapshot.data!['phoneNumber'];
                                  email = snapshot.data!['email'];

                                  return Column(
                                    children: [
                                      ProfileMenuWidget(
                                        titleText: email,
                                        icon: LineAwesomeIcons.envelope,
                                        color: Colors.black,
                                        endIcon: false,
                                      ),
                                      ProfileMenuWidget(
                                        titleText: 'Password',
                                        icon: LineAwesomeIcons.lock,
                                        color: Colors.black,
                                        onTap: () {
                                          //TODO: Change password
                                          MyApp.navigatorKey.currentState!
                                              .pushNamed('/editPwd');
                                        },
                                        endIcon: true,
                                      ),
                                      ProfileMenuWidget(
                                        titleText: '+60 $phoneNumber',
                                        icon: LineAwesomeIcons.phone,
                                        color: Colors.black,
                                        onTap: () {
                                          //!Change PHONE NUMBER
                                          MyApp.navigatorKey.currentState!
                                              .pushNamed('/adminEditPhoneNo');
                                        },
                                        endIcon: true,
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(),
                                      const SizedBox(height: 20),
                                      ProfileMenuWidget(
                                        titleText: 'Sign Out',
                                        icon:
                                            LineAwesomeIcons.alternate_sign_out,
                                        color: Colors.black,
                                        endIcon: false,
                                        onTap: () {
                                          FirebaseAuth.instance.signOut();
                                          MyApp.navigatorKey.currentState!
                                              .pushNamed('/');
                                        },
                                      ),
                                    ],
                                  );
                                }
                                return const Text("Test");
                              }),
                        ),
                      ),
                    ),
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
