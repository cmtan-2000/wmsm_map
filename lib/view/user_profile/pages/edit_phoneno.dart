import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

class EditPhoneNumber extends StatelessWidget {
  const EditPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: const EditPhonePageWidget(),
      title: 'Edit Password',
      user: user,
    );
  }
}

class EditPhonePageWidget extends StatefulWidget {
  const EditPhonePageWidget({super.key});

  @override
  State<EditPhonePageWidget> createState() => _EditPhonePageWidgetState();
}

class _EditPhonePageWidgetState extends State<EditPhonePageWidget> {
  late String _phoneno;
  late TextEditingController phoneNoEC;

  @override
  void initState() {
    super.initState();
    phoneNoEC = TextEditingController();
    _phoneno = user.phoneNumber; //*Init display user saved dao der password
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Old phone number',
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
                shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            child: const Icon(LineAwesomeIcons.phone, color: Colors.black),
          ),
          title: Text(
            _phoneno,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 50.0),
        Text(
          'New phone number',
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25.0),
        CustomTextFormField(
          context: context,
          isNumberOnly: true,
          labelText: 'Please enter new phone number',
          hintText: '011-1234567',
          controller: phoneNoEC,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                  onPressed: () {
                    snackBar("Update successfully!");
                    setState(() {
                      _phoneno = phoneNoEC.text;
                      //TODO: but not yet update into database
                    });
                  },
                  child: const Text('UPDATE')),
            ),
          ],
        ),
      ],
    );
  }
}
