import 'package:article_web/models/article/article_model.dart';
import 'package:article_web/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/responsive_widget.dart';

class UpdateArticleBody extends StatefulWidget {
  final ArticleModel? selectedArticle;

  const UpdateArticleBody(
    this.selectedArticle, {
    super.key,
  });

  @override
  State<UpdateArticleBody> createState() => _UpdateArticleBodyState();
}

class _UpdateArticleBodyState extends State<UpdateArticleBody> {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.selectedArticle?.toMap());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.selectedArticle?.title ?? '';
    descController.text = widget.selectedArticle?.description ?? '';
    print('title->${titleController.text}');
    return ResponsiveWidget(
      builder: (type) {
        if (type == DeviceType.WEB) {
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
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _getImage(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await Provider.of<ArticleProvider>(context, listen: false).updateImage();
                    },
                    child: const Text('Change Image'),
                  ),
                  const SizedBox(height: 20),
                  _getArticleDescription(),
                ],
              ),
            ),
          );
        } else {
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
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _getImage(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await Provider.of<ArticleProvider>(context, listen: false).updateImage();
                    },
                    child: const Text('Change Image'),
                  ),
                  const SizedBox(height: 20),
                  _getArticleDescription(),
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
          "Update Article Details",
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
        hintText: 'Update Title',
        hintStyle: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      controller: titleController,
      onChanged: ((value){
        widget.selectedArticle?.title = value;
      }),
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
        hintText: 'Update Article Description...',
        hintStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      controller: descController,
      maxLines: null,
      onChanged: ((value) {
        widget.selectedArticle?.description = value;
      }),
    );
  }

  Widget _getImage() {
    if (widget.selectedArticle?.image != null) {
      return Image.memory(
        widget.selectedArticle!.image!,
        fit: BoxFit.contain,
        height: 200,
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
