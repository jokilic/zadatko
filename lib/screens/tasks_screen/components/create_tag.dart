import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/errors.dart';
import '../../../constants/general.dart';
import '../../../constants/tasks_screen.dart';
import './color_picker.dart';
import '../tasks_screen.dart';
import '../../../components/zadatko_text_field.dart';
import '../../../components/zadatko_button.dart';
import '../../../models/tag.dart';

double tagModalHeightPercentage;

// Modal that is shown when the user taps the Tag icon
void createTag(BuildContext context) {
  chosenColor = null;
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  tagModalHeightPercentage = 0.5;

  bool tagModalValidation = true;

  // Gets called when the user presses the 'Create tag' button
  Future<void> addTag() async {
    try {
      tagModalValidation = true;

      // Validation fails if the tag text is empty
      if (titleController.text.isEmpty) {
        tagModalValidation = false;
        tagModalHeightPercentage = 0.6;
        throw (tagTitleEmptyErrorString);
      }

      // Validation fails if the tag title is the same as any already created tag title
      localListAllTags.forEach((tag) {
        if (titleController.text == tag.title) {
          tagModalValidation = false;
          throw (tagSameNameErrorString);
        }
      });

      // Tag gets created
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
    } catch (e) {
      throw (createTagErrorString);
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
                addTagString,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 36.0),
              ),
              SizedBox(height: 24.0),
              ZadatkoTextField(
                hintText: tagNameHintString,
                textEditingController: titleController,
                focusNode: titleFocusNode,
                onEditingComplete: () async {
                  await addTag();
                  setTagModalState(() {});
                },
              ),
              SizedBox(height: 32.0),
              ColorPicker(),
              SizedBox(height: 32.0),
              ZadatkoButton(
                text: addTagButtonString,
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
