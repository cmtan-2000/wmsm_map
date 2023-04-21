import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

class SignUpForm3Widget extends StatefulWidget {
  const SignUpForm3Widget({
    super.key,
  });

  @override
  State<SignUpForm3Widget> createState() => _SignUpForm3WidgetState();
}

class _SignUpForm3WidgetState extends State<SignUpForm3Widget> {
  bool _selectedValue = false;

  final _formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();

  late TextEditingController nameEC;
  late TextEditingController nickEC;
  late TextEditingController typeEC;
  late TextEditingController noEC;
  late TextEditingController dobEC;
  late TextEditingController phoneEC;
  late TextEditingController emailEC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameEC = TextEditingController();
    nickEC = TextEditingController();
    typeEC = TextEditingController();
    noEC = TextEditingController();
    dobEC = TextEditingController();
    phoneEC = TextEditingController();
    emailEC = TextEditingController();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobEC.text = DateFormat('yyyy-MM-dd').format(picked);
        print(dobEC);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set Up Profile',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const Text(
              'Help us to understand you better by filling up your Profile Information below.'),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
              context: context,
              isNumberOnly: false,
              hintText: 'Name (as per IC)',
              controller: nameEC),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              context: context,
              isNumberOnly: false,
              maxLength: 10,
              hintText: 'Nickname',
              controller: nickEC),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              context: context,
              isNumberOnly: false,
              hintText: 'ID Type',
              controller: typeEC),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              context: context,
              isNumberOnly: true,
              hintText: 'ID Number',
              controller: noEC),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              context: context,
              isNumberOnly: true,
              hintText: 'Date of Birth',
              onTap: () => _selectDate(context),
              readOnly: true,
              suffixicon: const Icon(Icons.calendar_month),
              controller: dobEC),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              context: context,
              isNumberOnly: true,
              hintText: 'Mobile',
              controller: phoneEC),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              context: context,
              isNumberOnly: false,
              hintText: 'Email Address',
              controller: emailEC),
          const SizedBox(
            height: 10,
          ),
          const Text('Are you a XXX Bank group empolyee? '),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: false,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          })
                    ],
                  ),
                  const Text('No'),
                ],
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: true,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          })
                    ],
                  ),
                  const Text('Yes'),
                ],
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                    onPressed: () {
                      print('CONTINUE');
                      Navigator.pushNamed(context, '/f4');
                    },
                    child: const Text('CONTINUE')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
