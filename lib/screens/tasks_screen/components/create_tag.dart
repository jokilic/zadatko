import 'package:flutter/material.dart';

import '../../../constants.dart';
import './color_picker.dart';
import '../tasks_screen.dart';
import '../../../components/zadatko_text_field.dart';
import '../../../components/zadatko_button.dart';
import '../../../models/tag.dart';

double tagModalHeightPercentage;

void createTag(BuildContext context) {
  chosenColor = null;
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  tagModalHeightPercentage = 0.5;

  bool tagModalValidation = true;

  Future<void> addTag() async {
    tagModalValidation = true;
    if (titleController.text.isEmpty) {
      tagModalValidation = false;
      tagModalHeightPercentage = 0.6;
    }

    if (tagModalValidation == true) {
      await firestore.createTagFirebase(
        Tag(
          title: titleController.text.trim(),
          color: chosenColor ?? 0,
        ),
      );

      await firestore.getTagsFirebase();

      Navigator.pop(context);
    }
  }

  Size size = MediaQuery.of(context).size;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setTagModalState) => SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: darkColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 28.0,
          ),
          height: size.height * tagModalHeightPercentage,
          width: size.width,
          child: Column(
            children: [
              Text(
                'Add a new tag',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 36.0),
              ),
              SizedBox(height: 24.0),
              ZadatkoTextField(
                hintText: 'Name',
                textEditingController: titleController,
                focusNode: titleFocusNode,
                onEditingComplete: () {
                  setTagModalState(() {
                    addTag();
                  });
                },
              ),
              SizedBox(height: 32.0),
              ColorPicker(),
              SizedBox(height: 16.0),
              if (!tagModalValidation)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Where\'s the name, you jabroni.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 26.0),
                  ),
                ),
              SizedBox(height: 24.0),
              ZadatkoButton(
                text: 'Create tag',
                onTap: () async {
                  await addTag();
                  setTagModalState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
