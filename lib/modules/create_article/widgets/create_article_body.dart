import 'dart:typed_data';

import 'package:article_web/custom_widgets/responsive_widget.dart';
import 'package:article_web/firebase/firebase_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateArticleBody extends StatefulWidget {
  TextEditingController titleController;
  TextEditingController descriptionController;
  ValueChanged<Uint8List> image;

  CreateArticleBody(
      {super.key,
      required this.titleController,
      required this.descriptionController,
      required this.image});

  @override
  State<CreateArticleBody> createState() => _CreateArticleBodyState();
}

class _CreateArticleBodyState extends State<CreateArticleBody> {

  FirebaseHelper firebaseHelper = FirebaseHelper();
  final storageRef = FirebaseStorage.instance.ref();
  Uint8List? webImage;

  Future uploadImage() async {
    // WEB
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        widget.image(f);
        webImage = f;
      });
    }
    // MOBILE
    // if (!kIsWeb) {
    //   final ImagePicker _picker = ImagePicker();
    //   XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //
    //   if (image != null) {
    //     var selected = File(image.path);
    //       _file = selected;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (type) {
        if(type == DeviceType.WEB){
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: MediaQuery.sizeOf(context).width / 3.5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerText,
                  const SizedBox(
                    height: 20,
                  ),
                  _getArticleTitle(),
                  _getArticleDescription(),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 45,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        uploadImage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Text('Choose File'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _getImage(),
                ],
              ),
            ),
          );
        }
        else{
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerText,
                  const SizedBox(
                    height: 20,
                  ),
                  _getArticleTitle(),
                  _getArticleDescription(),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 35,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        uploadImage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Text('Choose File'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _getImage(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  get _headerText => const Center(
        child: Text(
          "Write Article",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 50,
          ),
        ),
      );

  Widget _getArticleTitle() {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        hintText: 'Title',
        hintStyle: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      controller: widget.titleController,
    );
  }

  Widget _getArticleDescription() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.normal,
        color: Colors.grey,
      ),
      decoration: const InputDecoration(
        hintText: 'Article Description...',
        hintStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      controller: widget.descriptionController,
      maxLines: null,
    );
  }

  Widget _getImage() {
    if (webImage != null) {
      return Image.memory(
        webImage!,
        height: 200,
      );
    }
    return const SizedBox();
  }
}
