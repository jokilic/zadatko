import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zadatko/screens/tasks_screen/components/update_delete_tag.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/general.dart';
import '../../constants/tasks_screen.dart';
import './components/task_widget.dart';
import './components/tag_widget.dart';
import './components/change_name.dart';
import './components/create_tag.dart';
import './components/create_task.dart';
import './components/update_delete_task.dart';
import '../../models/my_firestore.dart';

enum ShortText {
  title,
  description,
}

int chosenTagMainScreen;
MyFirestore firestore = MyFirestore();
String chosenName;

// Set to true if there's no name set for the user - User just signed up
bool firstStart = false;

// Created because 'initState()' got triggered on each screen redraw
bool getDataBool = true;

class TasksScreen extends StatefulWidget {
  static const routeName = '/tasks-screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();

    // Gets called when the user starts the app
    if (getDataBool) getData();
    getDataBool = false;
  }

  Future<void> getData() async {
    // Initialize Firebase
    await firestore.initializeFirebase();
    // Set default values if they don't exist
    await firestore.setDefaultValues();
    // Store the name from Firebase
    chosenName = await firestore.getNameFirebase();
    // Get tags from Firebase and store them in 'listTags'
    await firestore.getTagsFirebase();
    // Get tasks from Firebase and store them in 'listTasks'
    await firestore.getTasksFirebase();

    // If there is no name (first time logged in), open 'changeName' Modal
    if (firstStart == true) changeName(context);

    setState(() {});
  }

  // Trims the text in order not to overflow the screen
  String createShortText({
    int index,
    ShortText shortText,
    int numberOfCharacters,
  }) {
    String currentText;
    if (shortText == ShortText.title)
      currentText = localListFilteredTasks[index].title;
    else
      currentText = localListFilteredTasks[index].description;

    if (currentText.length > numberOfCharacters)
      return '${currentText.substring(0, numberOfCharacters)}...';
    return currentText;
  }

  void filterTasks(int index) {
    setState(() {
      // If already selected Tag is pressed, set 'chosenTagMainScreen' to NULL
      chosenTagMainScreen == index
          ? chosenTagMainScreen = null
          : chosenTagMainScreen = index;
    });

    // If 'chosenTagMainScreen' is NULL, show all tasks
    if (chosenTagMainScreen == null)
      localListFilteredTasks = localListAllTasks;
    else
      // Filter tasks by the title of the chosen tag
      localListFilteredTasks = localListAllTasks
          .where(
            (task) =>
                task.tag.title == localListAllTags[chosenTagMainScreen].title,
          )
          .toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Container(
          width: size.width,
          child: Column(
            children: [
              ///////////////////////
              // INFO & TAGS BUTTONS
              ///////////////////////
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => print('Open info screen'),
                      child: SvgPicture.asset(
                        infoIcon,
                        width: 30.0,
                        color: lightColor,
                      ),
                    ),
                    GestureDetector(
                      // Open modal to create tag
                      onTap: () => createTag(context),
                      child: SvgPicture.asset(
                        tagIcon,
                        width: 32.0,
                        color: lightColor,
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////
              // HEADER TEXT
              ///////////////////////
              GestureDetector(
                onLongPress: () => changeName(context),
                child: Text(
                  '$helloString $chosenName',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 36.0),
                ),
              ),
              Text(
                '$numberOfTasksFirstString ${localListFilteredTasks.length} $numberOfTasksSecondString',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 28.0),
              ),
              SizedBox(height: 36.0),
              ///////////////////////
              // TAGS
              ///////////////////////
              if (localListAllTags.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 45.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: localListAllTags.length,
                      itemBuilder: (context, index) => TagWidget(
                        title: localListAllTags[index].title,
                        backgroundColor: chosenTagMainScreen == index
                            ? lightColor
                            : tagColors[localListAllTags[index].color],
                        textColor: chosenTagMainScreen == index
                            ? darkColor
                            : lightColor,
                        onTap: () => filterTasks(index),
                        onLongPress: () => updateDeleteTag(
                          context: context,
                          onTap: () async {
                            await updateTag(context);
                            setState(() {});
                          },
                          deleteTag: () async {
                            await deleteTag(
                              context,
                              localListAllTags[index],
                            );
                            setState(() {});
                          },
                          tag: localListAllTags[index],
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 24.0),
              Expanded(
                child: Stack(
                  children: [
                    ///////////////////////
                    // TASKS
                    ///////////////////////
                    if (localListFilteredTasks.isNotEmpty)
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: localListFilteredTasks.length,
                        itemBuilder: (context, index) => TaskWidget(
                          title: createShortText(
                            index: index,
                            shortText: ShortText.title,
                            numberOfCharacters: 25,
                          ),
                          description: createShortText(
                            index: index,
                            shortText: ShortText.description,
                            numberOfCharacters: 40,
                          ),
                          color: tagColors[
                              localListFilteredTasks[index].tag.color],
                          onTap: () {
                            setState(() {
                              // Toggle the 'isDone' state of the tapped task
                              localListFilteredTasks[index].isDone =
                                  !localListFilteredTasks[index].isDone;
                            });

                            // Toggle 'isDone' in Firebase
                            firestore.toggleIsDoneFirebase(
                                localListFilteredTasks[index]);
                          },
                          onLongPress: () => updateDeleteTask(
                            context: context,
                            onTap: () async {
                              await updateTask(context);
                              setState(() {});
                            },
                            deleteTask: () async {
                              await deleteTask(
                                context,
                                localListFilteredTasks[index],
                              );
                              setState(() {});
                            },
                            task: localListFilteredTasks[index],
                          ),
                          icon: localListFilteredTasks[index].isDone
                              ? checkboxCheckedIcon
                              : checkboxUncheckedIcon,
                        ),
                      ),
                    ///////////////////////
                    // ADD TASK FAB
                    ///////////////////////
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: FloatingActionButton(
                        onPressed: () => createTask(
                          context: context,
                          onTap: () async {
                            await addTask(context);
                            setState(() {});
                          },
                        ),
                        child: SvgPicture.asset(
                          addIcon,
                          width: 24.0,
                          color: darkColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
