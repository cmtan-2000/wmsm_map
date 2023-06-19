import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/shared/multi_line_field.dart';
import 'package:wmsm_flutter/viewmodel/article_view/article_view_model.dart';

class AdminInsertArticlePage extends StatefulWidget {
  const AdminInsertArticlePage({super.key});

  @override
  State<AdminInsertArticlePage> createState() => _AdminInsertArticlePageState();
}

class _AdminInsertArticlePageState extends State<AdminInsertArticlePage> {
  final _formKey = GlobalKey<FormState>();
  //* a -> author
  late TextEditingController aTitle;
  late TextEditingController aEventDate;
  late TextEditingController aContent;
  late TextEditingController aAuthor;
  //date format
  var dateFormat = DateFormat('yyyy-MM-dd');
  String imageChallenge = '';
  String publishDate = '';
  bool isImgLoading = false;
  bool isButtonDisabled = false;

  //upload image
  @override
  void initState() {
    super.initState();
    aTitle = TextEditingController();
    aEventDate = TextEditingController();
    aContent = TextEditingController();
    aAuthor = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    aTitle.dispose();
    aEventDate.dispose();
    aContent.dispose();
    aAuthor.dispose();
  }

  //add pickImage
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
      await referenceImageToUpload.putFile(File(image.path));
      String imageUrl = await referenceImageToUpload.getDownloadURL();
      completer.complete(imageUrl);
    } on PlatformException catch (e) {
      Logger().e("Failed to pick image: $e");
      completer.complete('');
    }

    return completer.future;
  }

  void _startLoading() {
    setState(() {
      isButtonDisabled = true;
      isImgLoading = true;
    });

    Timer(const Duration(seconds: 4), () {
      setState(() {
        isButtonDisabled = false;
        isImgLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Add Article',
                style: Theme.of(context).textTheme.bodyMedium),
            automaticallyImplyLeading: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      context: context,
                      controller: aTitle,
                      isNumberOnly: false,
                      labelText: 'Article Title',
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      context: context,
                      controller: aAuthor,
                      isNumberOnly: false,
                      labelText: 'Article Author',
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                        context: context,
                        controller: aEventDate,
                        isNumberOnly: true,
                        labelText: 'Event Date',
                        readOnly: true,
                        suffixicon: const Icon(Icons.calendar_month),
                        textInputAction: TextInputAction.next,
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime(2090));

                          if (date != null) {
                            setState(() =>
                                aEventDate.text = dateFormat.format(date));
                          } else {
                            return;
                          }
                        }),
                    const SizedBox(height: 20),
                    multiLineTextField(
                      multiLineController: aContent,
                      hintText:
                          'Ex Exercising and staying active are necessarily in our daily lives ...',
                      labelText: 'Article Content',
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Ink(
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.black,
                            //     width: 1.0,
                            //   ),
                            //   borderRadius: BorderRadius.circular(8.0),
                            // ),
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
                                              imageChallenge = await pickImage(
                                                  ImageSource.camera);

                                              Logger().i(imageChallenge);
                                            },
                                            child: const Text(
                                              'Take Photo',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          CupertinoActionSheetAction(
                                            isDefaultAction: true,
                                            onPressed: () async {
                                              //*Choose photo from gallery
                                              imageChallenge = await pickImage(
                                                  ImageSource.gallery);
                                              Logger().i(imageChallenge);
                                            },
                                            child: const Text(
                                              'Choose from Gallery',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          //*Cancel option
                                          CupertinoActionSheetAction(
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                    16.0), // Set the inner padding
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.upload_rounded,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Upload article image',
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isImgLoading = true;
                                });

                                try {
                                  //initialise the view model
                                  final articleViewModel =
                                      Provider.of<ArticleViewModel>(context,
                                          listen: false);

                                  //publish date is set the day to publish the article
                                  publishDate =
                                      dateFormat.format(DateTime.now());

                                  //set all the article details
                                  articleViewModel.setArticle(
                                    aAuthor.text,
                                    aTitle.text,
                                    imageChallenge,
                                    publishDate,
                                    aContent.text,
                                    aEventDate.text,
                                  );

                                  // save data to the database
                                  await articleViewModel.saveData();
                                  
                                  await Future.delayed(
                                      const Duration(seconds: 10));

                                  setState(() {
                                    isImgLoading = true;
                                  });

                                  Navigator.pop(context);

                                  Logger().i('Data saved successfully');
                                } catch (e, stackTrace) {
                                  Logger().e('$e\n$stackTrace');
                                } finally {
                                  setState(() {
                                    isImgLoading = false;
                                  });
                                }
                              }
                            },
                            child: isImgLoading
                                ? const CircularProgressIndicator()
                                : const Text('Add Article'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
