import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: const EditPwdPageWidget(),
      title: 'Edit Password',
      user: user,
    );
  }
}

class EditPwdPageWidget extends StatefulWidget {
  const EditPwdPageWidget({super.key});

  @override
  State<EditPwdPageWidget> createState() => _EditPwdPageWidgetState();
}

class _EditPwdPageWidgetState extends State<EditPwdPageWidget> {
  late String _password;
  late TextEditingController pwdEC;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pwdEC = TextEditingController();
    _password = user.password; //*Init display user saved dao der password
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
            'Old password',
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
              child: const Icon(LineAwesomeIcons.lock, color: Colors.black),
            ),
            title: Text(
              _password,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 50.0),
          Text(
            'New password',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25.0),
          CustomTextFormField(
            context: context,
            isNumberOnly: false,
            labelText: 'New Password',
            hintText: '******',
            controller: pwdEC,
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
                        snackBar("Update successfully!");
                        setState(() {
                          _password = pwdEC.text;
                          //TODO: but not yet update into database
                        });
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
