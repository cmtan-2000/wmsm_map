import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

class EditEmail extends StatefulWidget {
  const EditEmail({super.key});

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: const EditEmailPageWidget(),
      title: 'Edit Email',
      user: user,
    );
  }
}

class EditEmailPageWidget extends StatefulWidget {
  const EditEmailPageWidget({super.key});

  @override
  State<EditEmailPageWidget> createState() => _EditEmailPageWidgetState();
}

class _EditEmailPageWidgetState extends State<EditEmailPageWidget> {
  late String _email;
  late TextEditingController emailEC;

  @override
  void initState() {
    super.initState();
    emailEC = TextEditingController();
    _email = user.email; //*Init display user saved dao der email
  }

  @override
  void dispose() {
    emailEC.dispose();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Old email',
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
            child: const Icon(LineAwesomeIcons.envelope, color: Colors.black),
          ),
          title: Text(
            _email,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 50.0),
        Text(
          'New email',
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25.0),
        CustomTextFormField(
          context: context,
          isNumberOnly: false,
          labelText: 'Please enter your new email',
          hintText: 'abc@gmail.com',
          controller: emailEC,
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
                      _email = emailEC.text;
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
