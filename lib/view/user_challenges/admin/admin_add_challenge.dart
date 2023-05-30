import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/model/new_challenge.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/shared/multi_line_field.dart';
import 'package:wmsm_flutter/viewmodel/shared/shared_pref.dart';

class AdminAddChallenge extends StatefulWidget {
  const AdminAddChallenge({super.key});

  @override
  State<AdminAddChallenge> createState() => _AdminAddChallengeState();
}

class _AdminAddChallengeState extends State<AdminAddChallenge> {
  //*    c -> challenge
  late TextEditingController cTitleEC;
  late TextEditingController cDurationEC;
  late TextEditingController cDescriptionEC;
  late TextEditingController cStepsEC;
  late List<TextEditingController> cVoucherEC;
  late SharedPref sharedPref = SharedPref();
  final _formKey = GlobalKey<FormState>();
  String imageChallenge = ''; //get the return image url from firebase
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    cTitleEC = TextEditingController();
    cDurationEC = TextEditingController();
    cDescriptionEC = TextEditingController();
    cStepsEC = TextEditingController();
    cVoucherEC = [TextEditingController()];
    super.initState();
  }

  @override
  void dispose() {
    Logger().i('AdminAddChallenge disposed');
    cTitleEC.dispose();
    cDurationEC.dispose();
    cDescriptionEC.dispose();
    cStepsEC.dispose();

    for (var controller in cVoucherEC) {
      controller.dispose();
    }

    super.dispose();
  }

//*store data into sharedpref
  Future<void> storeData() async {
    NewChallenge newChallenge = NewChallenge(
      newChallengeTitle: cTitleEC.text,
      newChallengeEventDuration: cDurationEC.text,
      newChallengeDesc: cDescriptionEC.text,
      newChallengeSteps: int.parse(cStepsEC.text),
      newChallengeImgPath: imageChallenge,
      newChallengeVoucher: cVoucherEC.map((e) => e.text).toList(),
    );

    sharedPref.save("newChallenge", newChallenge.toJson());
  }

  IconButton _iconButton(String option) {
    return IconButton(
      onPressed: () {
        if (option == 'add') {
          setState(() {
            TextEditingController controller = TextEditingController();
            cVoucherEC.add(controller);
          });
        } else if (option == 'remove' && cVoucherEC.isNotEmpty) {
          setState(() {
            TextEditingController controller = cVoucherEC.last;
            cVoucherEC.remove(controller);
            controller.dispose();
          });
        }
      },
      icon: option == 'add'
          ? const Icon(LineAwesomeIcons.plus)
          : const Icon(LineAwesomeIcons.minus),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.orange; // Apply a different color when pressed
          }
          return Theme.of(context).primaryColor; // Default color
        }),
      ),
    );
  }

  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<String> pickImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);

    final completer = Completer<String>();
    if (image == null) {
      completer.complete('');
      return completer.future;
    }

    Reference refRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = refRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(image.path);

    try {
      //*Store the file into storage
      await referenceImageToUpload.putFile(File(image.path));

      //*Get the URL of the file from storage
      String imageUrl = await referenceImageToUpload.getDownloadURL();

      Logger().d(imageUrl);
      completer.complete(imageUrl);
    } on PlatformException catch (e) {
      Logger().e("Failed to pick image: $e");
      completer.complete('');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text('Add Challenge',
                  style: Theme.of(context).textTheme.bodyLarge),
              automaticallyImplyLeading: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    child: Card(
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),

                              //*CHALLENGE TITLE
                              CustomTextFormField(
                                context: context,
                                isNumberOnly: false,
                                labelText: 'Challenge Title',
                                hintText: 'Ex: Walk 100 Miles',
                                controller: cTitleEC,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(
                                height: 18,
                              ),

                              //*CHALLENGE DURATION

                              CustomTextFormField(
                                context: context,
                                isNumberOnly: true,
                                labelText: 'Challenge Duration',
                                hintText: 'Challenge Duration',
                                onTap: () async {
                                  final DateTimeRange? dateTimeRange =
                                      await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(2019),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 2 * 365)),
                                  );

                                  if (dateTimeRange != null) {
                                    setState(
                                        () => selectedDates = dateTimeRange);
                                    cDurationEC.text =
                                        '${selectedDates.start.day}/${selectedDates.start.month}/${selectedDates.start.year} - ${selectedDates.end.day}/${selectedDates.end.month}/${selectedDates.end.year}';
                                  } else {
                                    return;
                                  }
                                },
                                readOnly: true,
                                suffixicon: const Icon(Icons.calendar_month),
                                controller: cDurationEC,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(
                                height: 18,
                              ),

                              //*CHALLENGE DESCRIPTION
                              multiLineTextField(
                                multiLineController: cDescriptionEC,
                              ),

                              const SizedBox(
                                height: 18,
                              ),

                              //*STEP GOAL
                              CustomTextFormField(
                                context: context,
                                isNumberOnly: true,
                                labelText: 'Step Goal',
                                hintText: 'Ex: 10000 steps',
                                controller: cStepsEC,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),

                              //*VOUCHER
                              //*DYNAMIC FORM FIELD
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _iconButton('add'),
                                  _iconButton('remove'),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: cVoucherEC.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: CustomTextFormField(
                                      context: context,
                                      isNumberOnly: false,
                                      labelText: 'Challenge Voucher',
                                      hintText: 'Ex: Free 1 month gym pass',
                                      controller: cVoucherEC[index],
                                      textInputAction: TextInputAction.next,
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoActionSheet(
                                                  actions: <CupertinoActionSheetAction>[
                                                    CupertinoActionSheetAction(
                                                      isDefaultAction: true,
                                                      onPressed: () async {
                                                        //*Take photo
                                                        imageChallenge =
                                                            await pickImage(
                                                                ImageSource
                                                                    .camera);

                                                        Logger()
                                                            .i(imageChallenge);
                                                      },
                                                      child: const Text(
                                                        'Take Photo',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                    CupertinoActionSheetAction(
                                                      isDefaultAction: true,
                                                      onPressed: () async {
                                                        //*Choose photo from gallery
                                                        imageChallenge =
                                                            await pickImage(
                                                                ImageSource
                                                                    .gallery);
                                                        Logger()
                                                            .i(imageChallenge);
                                                      },
                                                      child: const Text(
                                                        'Choose from Gallery',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                    //*Cancel option
                                                    CupertinoActionSheetAction(
                                                      isDestructiveAction: true,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                              16.0), // Set the inner padding
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.upload_rounded,
                                                color: Colors.black,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Upload challenge image',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomElevatedButton(
                                        child: const Text('Add Challenge'),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            List<String> voucherArray = [];
                                            for (var array in cVoucherEC) {
                                              Logger().d(array.text);
                                              voucherArray.add(array.text);
                                            }

                                            String stepString = cStepsEC.text;
                                            int stepGoal = 0;

                                            if (stepString.isNotEmpty) {
                                              try {
                                                stepGoal =
                                                    int.parse(cStepsEC.text);
                                              } catch (e, stackTrace) {
                                                Logger().e('$e\n$stackTrace');
                                              }
                                            }

                                            Logger().wtf(imageChallenge);

                                            //*Insert data into firebase
                                            Map<String, dynamic> data = {
                                              'challengers': [],
                                              'title': cTitleEC.text,
                                              'duration': cDurationEC.text,
                                              'description':
                                                  cDescriptionEC.text,
                                              'stepGoal': stepGoal,
                                              'voucher': FieldValue.arrayUnion(
                                                  voucherArray),
                                              'imageUrl': imageChallenge,
                                            };

                                            db
                                                .collection("challenges")
                                                .add(data)
                                                .then((value) {
                                              Logger().i('Challenge added');
                                            }).catchError((error) {
                                              Logger().w(
                                                  'Error inserting challenge into firebase');
                                            });
                                            storeData();
                                            await Future.delayed(
                                                const Duration(seconds: 3));
                                            Navigator.pop(context);
                                            snackBar('Challenge added');
                                          }
                                        }),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
