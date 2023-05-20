import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

import '../../../model/users.dart';
import '../../custom/widgets/bottom_navigator_bar.dart';

class EditPhoneNumber extends StatefulWidget {
  const EditPhoneNumber({super.key, required this.user});

  final Users user;

  @override
  State<EditPhoneNumber> createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: EditPhonePageWidget(user: widget.user),
      title: 'Edit Phone Number',
      users: widget.user,
    );
  }
}

class EditPhonePageWidget extends StatefulWidget {
  const EditPhonePageWidget({super.key, required this.user});

  final Users user;

  @override
  State<EditPhonePageWidget> createState() => _EditPhonePageWidgetState();
}

class _EditPhonePageWidgetState extends State<EditPhonePageWidget> {
  late String _phoneno;
  late TextEditingController phoneNoEC;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneNoEC = TextEditingController();
    _phoneno =
        widget.user.phoneNumber; //*Init display user saved dao der password
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
            'Current Phone Number',
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
              child: const Icon(LineAwesomeIcons.phone, color: Colors.black),
            ),
            title: Text(
              _phoneno,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 50.0),
          Text(
            'New Phone Number',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25.0),
          CustomTextFormField(
            context: context,
            isNumberOnly: true,
            labelText: 'New Phone Number',
            hintText: '',
            controller: phoneNoEC,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  child: const Text('UPDATE'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore db = FirebaseFirestore.instance;
                      db
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "phoneNumber": phoneNoEC.text,
                      }).then((_) {
                        print("success!");
                      }).catchError((error) =>
                              print('Failed to update username: $error'));
                              
                      snackBar("Update successfully!");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
