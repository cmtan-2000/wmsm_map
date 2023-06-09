import 'dart:async';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/api/localnotification_api.dart';
import 'package:wmsm_flutter/model/new_challenge.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/shared/multi_line_field.dart';
import 'package:wmsm_flutter/viewmodel/shared/shared_pref.dart';
import 'package:wmsm_flutter/viewmodel/voucher/voucher_view_model.dart';

import '../../../model/voucher.dart';
import '../../custom/widgets/awesome_snackbar.dart';

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
  List<List<TextEditingController>> voucherArray = [];
  List<String> voucherId = [];

  @override
  void initState() {
    cTitleEC = TextEditingController();
    cDurationEC = TextEditingController();
    cDescriptionEC = TextEditingController();
    cStepsEC = TextEditingController();
    cVoucherEC = [TextEditingController()];
    createController();

    super.initState();
    LocalNotification.init();
    // listenNotifications();
  }

  //*the moment click notification, it will listen here and direct to the page
  // void listenNotifications() =>
  //     LocalNotification.onNotifications.stream.listen(notificationDirect);

  // void notificationDirect(String? payload) {
  //   Logger().wtf("Check Payload: $payload");
  //   if (payload != null) {
  //     MyApp.navigatorKey.currentState!.pushNamed('/adminjoinChallenge');
  //     LocalNotification.clearPayload();
  //   }
  // }

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

  void createController() {
    TextEditingController nameV = TextEditingController();
    TextEditingController typeV = TextEditingController();
    TextEditingController quantityV = TextEditingController();
    TextEditingController expirationDateV = TextEditingController();
    TextEditingController priceV = TextEditingController();

    List<TextEditingController> vControllerArray = [];
    vControllerArray.add(nameV);
    vControllerArray.add(typeV);
    vControllerArray.add(quantityV);
    vControllerArray.add(expirationDateV);
    vControllerArray.add(priceV);

    voucherArray.add(vControllerArray);
  }

  void deleteController() {
    TextEditingController nameV = voucherArray.last[0];
    TextEditingController typeV = voucherArray.last[1];
    TextEditingController quantityV = voucherArray.last[2];
    TextEditingController expirationDateV = voucherArray.last[3];
    TextEditingController priceV = voucherArray.last[4];

    nameV.dispose();
    typeV.dispose();
    quantityV.dispose();
    expirationDateV.dispose();
    priceV.dispose();

    voucherArray.removeLast();
  }

  IconButton _iconButton(String option) {
    return IconButton(
      onPressed: () {
        if (option == 'add') {
          setState(() {
            TextEditingController controller = TextEditingController();
            cVoucherEC.add(controller);

            createController();
          });
        } else if (option == 'remove' && cVoucherEC.isNotEmpty) {
          setState(() {
            TextEditingController controller = cVoucherEC.last;
            cVoucherEC.remove(controller);
            controller.dispose();

            deleteController();
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
                                hintText:
                                    'Ex Walk 100 Miles in 30 days and gain exclusive rewards',
                                labelText: 'Challenge Description',
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
                                itemCount: voucherArray.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child:
                                        buildVoucherCard(voucherArray[index]),
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
                                            //*Get data from form
                                            // voucherArray
                                            // for(List<TextEditingController> voucher in voucherArray){
                                            //   for(TextEditingController controller in voucher){
                                            //     Logger().d(controller.text);
                                            //   }
                                            // }

                                            // insert data voucher to database
                                            

                                            // List<String> voucherArray = [];
                                            // for (var array in cVoucherEC) {
                                            //   Logger().d(array.text);
                                            //   voucherArray.add(array.text);
                                            // }

                                            processVouchers().then((value) {
                                              Logger().i(value);
                                              voucherId = value;
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
                                                'voucher': voucherId,
                                                'imageUrl': imageChallenge,
                                              };
                                              
                                              db
                                                  .collection("challenges")
                                                  .add(data)
                                                  .then((value) {
                                                final snackbar = Awesome.snackbar(
                                                    "Challenge",
                                                    "Enrolled to Challenge",
                                                    ContentType.success);
                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(snackbar);
                                              }).catchError((error) {
                                                final materialBanner =
                                                    Awesome.materialBanner(
                                                        "Challenge",
                                                        "Failed to Join Challenge",
                                                        ContentType.failure);
                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentMaterialBanner()
                                                  ..showMaterialBanner(
                                                      materialBanner);
                                              });
                                              storeData();
                                              Future.delayed(
                                                      const Duration(seconds: 4))
                                                  .then((value) =>
                                                      Navigator.pop(context));

                                            LocalNotification.showNotification(
                                              title: 'New Challenge Released',
                                              body:
                                                  'Challenge is released, check it out now!',
                                              payload: 'user_challenge',
                                            );
                                          });
                                        }}),
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

  // Card buildVoucherCard(
  //     String name,
  //     String type,
  //     int quantity,
  //     DateTime expirationDate,
  //     double price,
  //     TextEditingController customTextFieldController) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             name,
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Type: $type',
  //             style: TextStyle(
  //               fontSize: 16,
  //             ),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Quantity: $quantity',
  //             style: TextStyle(
  //               fontSize: 16,
  //             ),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Expiration Date: ${expirationDate.toString()}',
  //             style: TextStyle(
  //               fontSize: 16,
  //             ),
  //           ),
  //           SizedBox(height: 8),
  //           Text(
  //             'Price: \$${price.toStringAsFixed(2)}',
  //             style: TextStyle(
  //               fontSize: 16,
  //             ),
  //           ),
  //           SizedBox(height: 16),
  //           TextField(
  //             controller: customTextFieldController,
  //             decoration: InputDecoration(
  //               labelText: 'Custom Field',
  //               hintText: 'Enter your custom value',
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Card buildVoucherCard(List<TextEditingController> voucherEC) {
    return Card(
      color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            CustomTextFormField(
              context: context,
              controller: voucherEC[0],
              hintText: 'Enter your voucher Name',
              labelText: 'Voucher',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: CustomTextFormField(
                      context: context,
                      controller: voucherEC[1],
                      hintText: 'Enter your voucher Type',
                      labelText: 'Type',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    context: context,
                    controller: voucherEC[4],
                    hintText: 'Enter your voucher Price',
                    labelText: 'Price (RM)',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: CustomTextFormField(
                      context: context,
                      controller: voucherEC[2],
                      hintText: 'Enter your voucher Quantity',
                      labelText: 'Quantity',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      CustomTextFormField(
                        context: context,
                        controller: voucherEC[3],
                        hintText: 'Enter your voucher Expiration Date',
                        labelText: 'Expiration Date',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      Positioned.fill(
                        child: InkWell(
                          onTap: () {
                            _selectDate(context, voucherEC[3]);
                          },
                          child: Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text =
          picked.toString(); // Update the text field with selected date
    }
  }
  Future<List<String>> processVouchers() async {
    List<String> vArray = [];
    for (List<TextEditingController> voucher in voucherArray) {
      String resultVid = await insertVoucher(voucher);
      vArray.add(resultVid);
    }
    return Future.value(vArray);
  }

  Future<String> insertVoucher(List<TextEditingController> voucherEC) async {
    final voucher = Voucher(
      name: voucherEC[0].text,
      type: voucherEC[1].text,
      quantity: int.parse(voucherEC[2].text),
      expirationDate: voucherEC[3].text,
      price: voucherEC[4].text,
    );
    VoucherViewModel vm = VoucherViewModel();
    String vid  = await vm.insertVoucher(voucher);
    Logger().i('$vid inserted');
    return Future.value(vid);
    
  }
}
