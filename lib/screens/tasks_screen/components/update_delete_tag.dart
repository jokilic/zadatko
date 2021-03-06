import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../constants/errors.dart';
import '../../../constants/general.dart';
import '../../../constants/tasks_screen.dart';
import '../tasks_screen.dart';
import '../../../components/zadatko_text_field.dart';
import '../../../components/zadatko_button.dart';
import '../../../components/my_error_widget.dart';
import '../../../models/tag.dart';
import './color_picker.dart';

TextEditingController titleController = TextEditingController();
FocusNode titleFocusNode = FocusNode();
late double tagModalHeightPercentage;
bool? tagModalValidation;
late Tag oldTag;

// Initialize the 'UpdateDeleteTagError' enum
UpdateDeleteTagError updateDeleteTagError = UpdateDeleteTagError.no;

// Gets called when the user presses the 'Update tag' button
Future<void> updateTag(BuildContext context) async {
  print(titleController.text);

  try {
    // Validation fails if the title text is empty
    if (titleController.text.isEmpty) {
      tagModalValidation = false;
      updateDeleteTagError = UpdateDeleteTagError.titleEmpty;
      print(tagTitleEmptyErrorString);
      // throw (tagTitleEmptyErrorString);
    }
    // Validation fails if the tag title is the same as any already created tag title
    // And if the new title is not the same as the old title
    localListAllTags.forEach((tag) {
      if (titleController.text == tag.title) {
        if (titleController.text != oldTag.title) {
          tagModalValidation = false;
          updateDeleteTagError = UpdateDeleteTagError.titleSame;
          print(tagSameNameErrorString);
          // throw (tagSameNameErrorString);
        }
      }
    });

    // Tag  gets updated
    if (tagModalValidation == true) {
      Tag newTag = Tag(
        title: titleController.text.trim(),
        color: chosenColor == null ? 10 : chosenColor,
      );

      await firestore.updateTagFirebase(oldTag, newTag);
      await firestore.getTagsFirebase();

      Navigator.pop(context);
    }
  } catch (e) {
    updateDeleteTagError = UpdateDeleteTagError.updateError;
    print(updateTagErrorString);
    // throw (updateTagErrorString);
  }
}

// Gets called when the user presses the 'Delete tag' button
Future<void> deleteTag(BuildContext context, Tag tag) async {
  try {
    // If the tag is used in any task, throw error
    localListAllTasks.forEach((task) {
      if (task.tag!.title == tag.title) {
        tagModalValidation = false;
        updateDeleteTagError = UpdateDeleteTagError.tagUsed;
        print(tagUsedErrorString);
        // throw (tagUserErrorString);
      }
    });

    await firestore.deleteTagFirebase(tag);
    await firestore.getTagsFirebase();

    Navigator.pop(context);
  } catch (e) {
    updateDeleteTagError = UpdateDeleteTagError.deleteError;
    print(deleteTagErrorString);
    // throw (deleteTagErrorString);
  }
}

// Modal that is shown when the user long-taps any tag
void updateDeleteTag({
  required BuildContext context,
  required Function onTap,
  required Function deleteTag,
  required Tag tag,
}) {
  Size size = MediaQuery.of(context).size;

  updateDeleteTagError = UpdateDeleteTagError.no;

  // Save original tag
  oldTag = tag;

  titleController.text = tag.title!;
  titleFocusNode = FocusNode();
  tagModalHeightPercentage = 0.45;
  tagModalValidation = true;

  if (localListAllTags.length > 0) tagModalHeightPercentage = 0.55;

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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  updateTitleString,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 36.0),
                ),
                SizedBox(height: 24.0),
                ZadatkoTextField(
                  hintText: tagNameHintString,
                  textEditingController: titleController,
                  focusNode: titleFocusNode,
                  onEditingComplete: onTap,
                ),
                SizedBox(height: 36.0),
                ColorPicker(),
                SizedBox(height: 16.0),
                if (updateDeleteTagError == UpdateDeleteTagError.titleEmpty)
                  Column(
                    children: [
                      MyErrorWidget(taskTitleEmptyErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                if (updateDeleteTagError == UpdateDeleteTagError.titleSame)
                  Column(
                    children: [
                      MyErrorWidget(tagSameNameErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                if (updateDeleteTagError == UpdateDeleteTagError.updateError)
                  Column(
                    children: [
                      MyErrorWidget(updateTagErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                if (updateDeleteTagError == UpdateDeleteTagError.tagUsed)
                  Column(
                    children: [
                      MyErrorWidget(tagUsedErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                if (updateDeleteTagError == UpdateDeleteTagError.deleteError)
                  Column(
                    children: [
                      MyErrorWidget(deleteTagErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                SizedBox(height: 16.0),
                ZadatkoButton(
                  text: updateTagButtonString,
                  onTap: onTap,
                ),
                SizedBox(height: 16.0),
                ZadatkoButton(
                  text: deleteTagButtonString,
                  onTap: deleteTag,
                  color: redColor,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
