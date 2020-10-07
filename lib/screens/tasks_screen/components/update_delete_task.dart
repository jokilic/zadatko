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

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
FocusNode titleFocusNode = FocusNode();
FocusNode descriptionFocusNode = FocusNode();
bool taskModalValidation;
int chosenTagModal;
double taskModalHeightPercentage;
Task oldTask;

// Initialize the 'UpdateDeleteTaskError' enum
UpdateDeleteTaskError updateDeleteTaskError = UpdateDeleteTaskError.no;

// Gets called when the user presses the 'Update task' button
Future<void> updateTask(BuildContext context) async {
  try {
    taskModalValidation = true;

    // Validation fails if the title text is empty
    if (titleController.text.isEmpty) {
      taskModalValidation = false;
      updateDeleteTaskError = UpdateDeleteTaskError.titleEmpty;
      print(taskTitleEmptyErrorString);
      // throw (taskTitleEmptyErrorString);
    }
    // Validation fails if the task title is the same as any already created task title
    // And if the new title is not the same as the old title
    localListAllTasks.forEach((task) {
      if (titleController.text == task.title) {
        if (titleController.text != oldTask.title) {
          taskModalValidation = false;
          updateDeleteTaskError = UpdateDeleteTaskError.titleSame;
          print(taskSameNameErrorString);
          // throw (taskSameNameErrorString);
        }
      }
    });

    // Task gets updated
    if (taskModalValidation == true) {
      Task newTask = Task(
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
      );

      await firestore.updateTaskFirebase(oldTask, newTask);
      await firestore.getTasksFirebase();

      Navigator.pop(context);
    }
  } catch (e) {
    updateDeleteTaskError = UpdateDeleteTaskError.updateError;
    print(updateTaskErrorString);
    // throw (updateTaskErrorString);
  }
}

// Gets called when the user presses the 'Update task' button
Future<void> deleteTask(BuildContext context, Task task) async {
  try {
    await firestore.deleteTaskFirebase(task);
    await firestore.getTasksFirebase();

    Navigator.pop(context);
  } catch (e) {
    updateDeleteTaskError = UpdateDeleteTaskError.deleteError;
    print(deleteTaskErrorString);
    // throw (deleteTaskErrorString);
  }
}

// Modal that is shown when the user long-taps any task
void updateDeleteTask({
  @required BuildContext context,
  @required Function onTap,
  @required Function deleteTask,
  @required Task task,
}) {
  Size size = MediaQuery.of(context).size;

  updateDeleteTaskError = UpdateDeleteTaskError.no;

  // Save original task
  oldTask = task;

  titleController.text = task.title;
  descriptionController.text = task.description;
  titleFocusNode = FocusNode();
  descriptionFocusNode = FocusNode();
  taskModalHeightPercentage = 0.5;
  taskModalValidation = true;

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
                  updateTaskTitleString,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 36.0),
                ),
                SizedBox(height: 24.0),
                ZadatkoTextField(
                  hintText: updateTaskNameHintString,
                  textEditingController: titleController,
                  focusNode: titleFocusNode,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(descriptionFocusNode),
                ),
                SizedBox(height: 16.0),
                ZadatkoTextField(
                  hintText: updateTaskDescriptionHintString,
                  textEditingController: descriptionController,
                  focusNode: descriptionFocusNode,
                  onEditingComplete: null,
                  maxLines: null,
                  textInputType: TextInputType.multiline,
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
                SizedBox(height: 16.0),
                if (updateDeleteTaskError == UpdateDeleteTaskError.titleEmpty)
                  Column(
                    children: [
                      MyErrorWidget(taskTitleEmptyErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                if (updateDeleteTaskError == UpdateDeleteTaskError.titleSame)
                  Column(
                    children: [
                      MyErrorWidget(taskSameNameErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                if (updateDeleteTaskError == UpdateDeleteTaskError.updateError)
                  Column(
                    children: [
                      MyErrorWidget(updateTaskErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                if (updateDeleteTaskError == UpdateDeleteTaskError.deleteError)
                  Column(
                    children: [
                      MyErrorWidget(deleteTaskErrorString),
                      SizedBox(height: 16.0),
                    ],
                  ),
                SizedBox(height: 16.0),
                ZadatkoButton(
                  text: updateTaskButtonString,
                  onTap: onTap,
                ),
                SizedBox(height: 16.0),
                ZadatkoButton(
                  text: deleteTaskButtonString,
                  onTap: deleteTask,
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
