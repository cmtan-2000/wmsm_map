// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

final ScrollController _controller = ScrollController();

class SignUpForm3 extends StatefulWidget {
  const SignUpForm3({super.key});

  @override
  State<SignUpForm3> createState() => _SignUpForm3State();
}

class _SignUpForm3State extends State<SignUpForm3> {
  bool isExpanded = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        //if the scrolling position reaches maxium scrolling extent, expand
        isExpanded =
            _controller.position.pixels >= _controller.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Theme.of(context).primaryColor,
              ],
              stops: const [
                0.1,
                1.0,
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
        //*White container
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'Personal Information'.toUpperCase(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isExpanded
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: 55, horizontal: 30),
                          padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: const content(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class content extends StatefulWidget {
  const content({
    super.key,
  });

  @override
  State<content> createState() => _contentState();
}

class _contentState extends State<content> {
  bool _selectedValue = false;

  final _formKey = GlobalKey<FormState>();

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
    return SingleChildScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      child: Form(
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
      ),
    );
  }
}
