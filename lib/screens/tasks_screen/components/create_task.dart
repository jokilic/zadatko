import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../constants/errors.dart';
import '../../../constants/general.dart';
import '../../../constants/tasks_screen.dart';
import './tag_widget.dart';
import '../tasks_screen.dart';
import '../../../components/zadatko_text_field.dart';
import '../../../components/zadatko_button.dart';
import '../../../components/my_error_widget.dart';
import '../../../models/tag.dart';
import '../../../models/task.dart';

TextEditingController titleController;
TextEditingController descriptionController;
FocusNode titleFocusNode;
FocusNode descriptionFocusNode;
double taskModalHeightPercentage;
bool taskModalValidation;
int chosenTagModal;

// Initialize the 'CreateTaskError' enum
CreateTaskError createTaskError = CreateTaskError.no;

// Gets called when the user presses the 'Add task' button
Future<void> addTask(BuildContext context) async {
  try {
    taskModalValidation = true;

    // Validation fails if the title text is empty
    if (titleController.text.isEmpty) {
      taskModalValidation = false;
      createTaskError = CreateTaskError.titleEmpty;
      print(taskTitleEmptyErrorString);
      // throw (taskTitleEmptyErrorString);
    }
    // Validation fails if the task title is the same as any already created task title
    localListAllTasks.forEach((task) {
      if (titleController.text == task.title) {
        taskModalValidation = false;
        createTaskError = CreateTaskError.titleSame;
        print(taskSameNameErrorString);
        // throw (taskSameNameErrorString);
      }
    });

    // Task gets created
    if (taskModalValidation == true) {
      await firestore.createTaskFirebase(
        Task(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          tag: Tag(
            title: chosenTagModal == null
                ? 'no_tag'
                : localListAllTags[chosenTagModal].title,
            color: chosenTagModal == null
                ? 9
                : localListAllTags[chosenTagModal].color,
          ),
          isDone: false,
        ),
      );
      await firestore.getTasksFirebase();

      Navigator.pop(context);
    }
  } catch (e) {
    createTaskError = CreateTaskError.generalError;
    print(createTaskErrorString);
    // throw (createTaskErrorString);
  }
}

// Modal that is shown when the user taps the FAB
void createTask({
  @required BuildContext context,
  @required Function onTap,
}) {
  Size size = MediaQuery.of(context).size;

  titleController = TextEditingController();
  descriptionController = TextEditingController();
  titleFocusNode = FocusNode();
  descriptionFocusNode = FocusNode();
  taskModalHeightPercentage = 0.5;
  taskModalValidation = true;
  createTaskError = CreateTaskError.no;

  if (localListAllTags.length > 0) taskModalHeightPercentage = 0.6;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setTaskModalState) => SingleChildScrollView(
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
            horizontal: 10.0,
            vertical: 28.0,
          ),
          height: size.height * taskModalHeightPercentage,
          width: size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  addTitleString,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 36.0),
                ),
                SizedBox(height: 24.0),
                ZadatkoTextField(
                  hintText: taskNameHintString,
                  textEditingController: titleController,
                  focusNode: titleFocusNode,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(descriptionFocusNode),
                ),
                SizedBox(height: 16.0),
                ZadatkoTextField(
                  hintText: taskDescriptionHintString,
                  textEditingController: descriptionController,
                  focusNode: descriptionFocusNode,
                  onEditingComplete: null,
                  maxLines: null,
                ),
                SizedBox(height: 32.0),
                if (localListAllTags.length > 0)
                  SizedBox(
                    height: 50.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: localListAllTags.length,
                      itemBuilder: (context, index) => TagWidget(
                        title: localListAllTags[index].title,
                        backgroundColor: chosenTagModal == index
                            ? lightColor
                            : tagColors[localListAllTags[index].color],
                        textColor:
                            chosenTagModal == index ? darkColor : lightColor,
                        onTap: () {
                          setTaskModalState(() {
                            chosenTagModal == index
                                ? chosenTagModal = null
                                : chosenTagModal = index;
                          });
                        },
                        onLongPress: null,
                      ),
                    ),
                  ),
                SizedBox(height: 36.0),
                if (createTaskError == CreateTaskError.titleEmpty)
                  Column(
                    children: [
                      MyErrorWidget(taskTitleEmptyErrorString),
                      SizedBox(height: 36.0),
                    ],
                  ),
                if (createTaskError == CreateTaskError.titleSame)
                  Column(
                    children: [
                      MyErrorWidget(taskSameNameErrorString),
                      SizedBox(height: 36.0),
                    ],
                  ),
                if (createTaskError == CreateTaskError.generalError)
                  Column(
                    children: [
                      MyErrorWidget(createTaskErrorString),
                      SizedBox(height: 36.0),
                    ],
                  ),
                ZadatkoButton(
                  text: addTaskButtonString,
                  onTap: onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
