import 'package:flutter/material.dart';
import 'package:zadatko/constants.dart';

import '../../../constants.dart';
import '../../../models/my_firestore.dart';
import './tag_widget.dart';
import '../tasks_screen.dart';
import '../../../components/zadatko_text_field.dart';
import '../../../components/zadatko_button.dart';

void createTask(BuildContext context, Function tagTapped) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  bool validation = true;

  void addTask() {
    if (titleController.text.isEmpty) validation = false;

    if (validation == true) {
      // TODO: Implement validation and push new task
      Navigator.pop(context);
    }
  }

  Size size = MediaQuery.of(context).size;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => SingleChildScrollView(
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
          horizontal: 36.0,
          vertical: 28.0,
        ),
        height: size.height * 0.7,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'What needs to be done?',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 36.0),
            ),
            ZadatkoTextField(
              hintText: 'Title',
              textEditingController: titleController,
              focusNode: titleFocusNode,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(descriptionFocusNode),
            ),
            ZadatkoTextField(
              maxLines: null,
              hintText: 'Description',
              textEditingController: descriptionController,
              focusNode: descriptionFocusNode,
              onEditingComplete: () => null,
            ),
            Text(
              'Tag?',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 28.0),
            ),
            SizedBox(
              height: 50.0,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: listTags.length,
                itemBuilder: (context, index) => TagWidget(
                  title: listTags[index].title,
                  backgroundColor: tagColors[listTags[index].color],
                  textColor: chosenTag == index ? darkColor : lightColor,
                  onTap: tagTapped,
                ),
              ),
            ),
            ZadatkoButton(
              text: 'Add task',
              onTap: () => addTask(),
            ),
          ],
        ),
      ),
    ),
  );
}
