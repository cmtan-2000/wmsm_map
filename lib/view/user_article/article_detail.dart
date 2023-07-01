// ignore_for_file: use_build_context_synchronously

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
import 'package:wmsm_flutter/model/article.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/viewmodel/user_view_model.dart';

import '../../viewmodel/article/article_view_model.dart';
import '../custom/widgets/custom_elevatedbutton.dart';
import '../shared/multi_line_field.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({super.key, required this.article});

  final Article article;

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  // final String author;
  // final String title;
  // final String publishDate;
  // final String imgPath;
  // final String content;
  bool edit = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController aTitle = TextEditingController();
  final TextEditingController aEventDate = TextEditingController();
  final TextEditingController aContent = TextEditingController();
  final TextEditingController aAuthor = TextEditingController();
  final TextEditingController aPublishDate = TextEditingController();
  //date format
  var dateFormat = DateFormat('yyyy-MM-dd');
  String imageChallenge = '';

  @override
  void initState() {
    super.initState();
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
      await referenceImageToUpload.putFile(File(image.path));
      String imageUrl = await referenceImageToUpload.getDownloadURL();
      completer.complete(imageUrl);
    } on PlatformException catch (e) {
      Logger().e("Failed to pick image: $e");
      completer.complete('');
    }

    return completer.future;
  }

  void insertInput() {
    aTitle.text = widget.article.title;
    aAuthor.text = widget.article.author;
    aEventDate.text = widget.article.eventDate;
    aPublishDate.text = widget.article.publishDate;
    aContent.text = widget.article.content;
    imageChallenge = widget.article.imgPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(widget.article.title,
                style: Theme.of(context).textTheme.bodyLarge),
            actions: [
              Consumer<UserViewModel>(
                  builder: (context, value, child) => value.user.role == 'admin'
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              insertInput();
                              edit = !edit;
                            });
                          },
                          icon: edit
                              ? const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )
                              : const Icon(Icons.edit),
                        )
                      : const SizedBox()),
              Consumer<UserViewModel>(
                builder: (context, value, child) => value.user.role == 'admin'
                    ? IconButton(
                        onPressed: () {
                          // Display AlertDialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Article'),
                                content: const Text(
                                    'Are you sure you want to delete this article?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      //initialise the view model
                                      final articleViewModel =
                                          Provider.of<ArticleViewModel>(context,
                                              listen: false);

                                      //delete data from the database
                                      await articleViewModel
                                          .deleteData(widget.article.id);
                                      Logger().i('Data delete successfully');
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      )
                    : const SizedBox(),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.article.imgPath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    Visibility(
                      visible: !edit,
                      replacement: Positioned.fill(
                          child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
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
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Upload challenge image',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                      child: Positioned(
                        bottom: 10,
                        left: 20,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.article.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Author: ${widget.article.author}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  'Date: ${widget.article.publishDate}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                !edit
                    ? Wrap(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              "[Event date: ${widget.article.eventDate}]\n\n${widget.article.content}",
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
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
                                      setState(() => aEventDate.text =
                                          dateFormat.format(date));
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
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            //initialise the view model
                                            final articleViewModel =
                                                Provider.of<ArticleViewModel>(
                                                    context,
                                                    listen: false);

                                            //set all the article details
                                            articleViewModel.setArticle(
                                                aAuthor.text,
                                                aTitle.text,
                                                imageChallenge,
                                                aPublishDate.text,
                                                aContent.text,
                                                aEventDate.text);

                                            Logger().i(imageChallenge);

                                            // save data to the database
                                            await articleViewModel
                                                .updateData(widget.article.id);
                                            Logger()
                                                .i('Data update successfully');
                                            Navigator.pop(context);
                                          } catch (e, stackTrace) {
                                            Logger().e('$e\n$stackTrace');
                                          }
                                        }
                                      },
                                      child: const Text('Update Article'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
