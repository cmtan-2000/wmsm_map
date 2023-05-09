import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/admin_profile/admin_profile_pic.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

class AdminEditPhoneNo extends StatelessWidget {
  const AdminEditPhoneNo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(1, 255, 123, 1),
          elevation: 0,
          title: Text('Edit Phone Number',
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
                        children: const [
                          AdminProfilePicture(),
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
                children: const [
                  Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                        child: AdminEditPhoneNoWidget(),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class AdminEditPhoneNoWidget extends StatefulWidget {
  const AdminEditPhoneNoWidget({super.key});

  @override
  State<AdminEditPhoneNoWidget> createState() => _AdminEditPhoneNoWidgetState();
}

//!page for admin to edit phone number
class _AdminEditPhoneNoWidgetState extends State<AdminEditPhoneNoWidget> {
  late String _phoneno;
  late TextEditingController phoneNoEC;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneNoEC = TextEditingController();
    //!hardcode
    _phoneno = '0189575682'; //*Init display user saved dao der password
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

                      //!admin collection
                      db
                          .collection("admin")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "phoneNumber": phoneNoEC.text,
                      }).then((_) {
                        print("success!");
                      }).catchError((error) =>
                              print('Failed to update username: $error'));

                      snackBar("Update successfully!");
                      print(phoneNoEC.text);

                      setState(() {
                        _phoneno = phoneNoEC.text;
                      });

                      MyApp.navigatorKey.currentState!.pop();
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
