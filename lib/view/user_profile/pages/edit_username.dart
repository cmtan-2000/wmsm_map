import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

import '../../../model/users.dart';
import '../../custom/widgets/bottom_navigator_bar.dart';

class EditUserName extends StatefulWidget {
  const EditUserName({super.key, required this.user});

  final Users user;

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  @override
  Widget build(BuildContext context) {
    Logger().d(widget.user.username);
    return CoverInfo(
      content: EditUserNamePageWidget(
        username: widget.user.username,
      ),
      title: 'Edit Username',
      users: widget.user,
    );
  }
}

class EditUserNamePageWidget extends StatefulWidget {
  const EditUserNamePageWidget({super.key, required this.username});

  final String username;

  @override
  State<EditUserNamePageWidget> createState() => _EditUserNamePageWidgetState();
}

class _EditUserNamePageWidgetState extends State<EditUserNamePageWidget> {
  late String _username;
  late TextEditingController usernameEC;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameEC = TextEditingController();
    _username = widget.username; //*Init display user saved dao der username
  }

  @override
  void dispose() {
    usernameEC.dispose();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Username',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: const Icon(LineAwesomeIcons.user, color: Colors.black),
            ),
            title: Text(
              _username,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 50.0),
          Text(
            'New Username',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25.0),
          CustomTextFormField(
            context: context,
            isNumberOnly: false,
            labelText: 'New Username',
            hintText: '',
            controller: usernameEC,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore db = FirebaseFirestore.instance;

                        db
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "username": usernameEC.text,
                        }).then((_) {
                          Logger().d("success!");
                        }).catchError((error) => Logger().d(error));

                        snackBar("Update successfully!");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavScreen(),
                          ),
                        );
                      }
                    },
                    child: const Text('UPDATE')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
