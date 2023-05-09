import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

class EditUserName extends StatefulWidget {
  const EditUserName({super.key});

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: const EditUserNamePageWidget(),
      title: 'Edit Username',
      users: users,
    );
  }
}

class EditUserNamePageWidget extends StatefulWidget {
  const EditUserNamePageWidget({super.key});

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
    _username = users.username; //*Init display user saved dao der username
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
            'Old username',
            style: Theme.of(context)
                .textTheme
                .displaySmall
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
            'New username',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25.0),
          CustomTextFormField(
            context: context,
            isNumberOnly: false,
            labelText: 'New username',
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
                          print("success!");
                        }).catchError((error) =>
                                print('Failed to update username: $error'));

                        snackBar("Update successfully!");
                        setState(() {
                          _username = usernameEC.text;
                        });
                        MyApp.navigatorKey.currentState!.pop();
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
