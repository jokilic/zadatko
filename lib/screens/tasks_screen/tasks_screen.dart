import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/errors.dart';
import '../../constants/icons.dart';
import '../../constants/general.dart';
import '../../constants/tasks_screen.dart';
import '../../components/my_error_widget.dart';
import '../../components/loading.dart';
import './components/task_widget.dart';
import './components/tag_widget.dart';
import './components/change_name.dart';
import './components/create_tag.dart';
import './components/create_task.dart';
import './components/update_delete_tag.dart';
import './components/update_delete_task.dart';
import '../../components/illustration.dart';
import '../../models/my_firestore.dart';
import '../info_screen/info_screen.dart';

int chosenTagMainScreen;
MyFirestore firestore = MyFirestore();
String chosenName;

// Set to true if there's no name set for the user
bool firstStart = false;
bool loadingScreen = true;

class TasksScreen extends StatefulWidget {
  static const routeName = '/tasks-screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();

    loadingScreen = true;
    myFirebaseError = MyFirebaseError.no;
    getData();
  }

  Future<void> getData() async {
    loadingScreen = true;

    try {
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
      if (firstStart == true) {
        changeName(context);
        firstStart = false;
      }

      loadingScreen = false;

      setState(() {});
    } catch (e) {
      myFirebaseError = MyFirebaseError.initialize;
      loadingScreen = false;
      print(firestoreInitializeError);
      // throw (firestoreInitializeError);
    }
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

    // Replace all new lines with spaces
    currentText = currentText.replaceAll('\n', ' ');

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
        // Show loading screen until everything gets loaded
        child: loadingScreen == true ? Loading() : buildTasksScreen(size),
      ),
    );
  }

  Widget buildTasksScreen(Size size) {
    return Column(
      children: [
        ///////////////////////
        // ERRORS
        ///////////////////////

        // Initialization errors
        if (myFirebaseError == MyFirebaseError.initialize)
          MyErrorWidget(firestoreInitializeError),
        if (myFirebaseError == MyFirebaseError.setDefault)
          MyErrorWidget(firestoreDefaultValuesError),

        // Name errors
        if (myFirebaseError == MyFirebaseError.getName)
          MyErrorWidget(firestoreGettingNameError),
        if (myFirebaseError == MyFirebaseError.updateName)
          MyErrorWidget(firestoreUpdatingNameError),

        // Task errors
        if (myFirebaseError == MyFirebaseError.getTasks)
          MyErrorWidget(firestoreGettingTasksError),
        if (myFirebaseError == MyFirebaseError.createTask)
          MyErrorWidget(firestoreCreatingTaskError),
        if (myFirebaseError == MyFirebaseError.updateTask)
          MyErrorWidget(firestoreUpdatingTaskError),
        if (myFirebaseError == MyFirebaseError.deleteTask)
          MyErrorWidget(firestoreDeletingTaskError),
        if (myFirebaseError == MyFirebaseError.toggleTask)
          MyErrorWidget(firestoreTogglingTaskError),

        // Tag errors
        if (myFirebaseError == MyFirebaseError.getTags)
          MyErrorWidget(firestoreGettingTagsError),
        if (myFirebaseError == MyFirebaseError.createTag)
          MyErrorWidget(firestoreCreatingTagsError),
        if (myFirebaseError == MyFirebaseError.updateTag)
          MyErrorWidget(firestoreUpdatingTagError),
        if (myFirebaseError == MyFirebaseError.deleteTag)
          MyErrorWidget(firestoreDeletingTagError),

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
                onTap: () => Navigator.pushNamed(
                  context,
                  InfoScreen.routeName,
                ),
                child: SvgPicture.asset(
                  infoIcon,
                  width: 30.0,
                  color: lightColor,
                ),
              ),
              GestureDetector(
                // Open modal to create tag
                onTap: () => createTag(
                  context: context,
                  onTap: () async {
                    await addTag(context);
                    setState(() {});
                  },
                ),
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
            style:
                Theme.of(context).textTheme.headline1.copyWith(fontSize: 36.0),
          ),
        ),
        Text(
          '$numberOfTasksFirstString ${localListFilteredTasks.length} $numberOfTasksSecondString',
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 28.0),
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
                  textColor:
                      chosenTagMainScreen == index ? darkColor : lightColor,
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
              // Show random illustration if there are no tasks
              if (localListFilteredTasks.isEmpty)
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Illustration(illustrationText),
                      SizedBox(height: 56.0),
                    ],
                  ),
                ),

              ///////////////////////
              // TASKS
              ///////////////////////
              if (localListFilteredTasks.isNotEmpty)
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: localListFilteredTasks.length,
                  itemBuilder: (context, index) {
                    // Add some spacing on the bottom if it's the last task
                    if (index == localListFilteredTasks.length - 1)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TaskWidget(
                            title: createShortText(
                              index: index,
                              shortText: ShortText.title,
                              numberOfCharacters: 25,
                            ),
                            description: createShortText(
                              index: index,
                              shortText: ShortText.description,
                              numberOfCharacters: 50,
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
                          SizedBox(height: 50.0),
                        ],
                      );

                    // Return standard task Widget
                    return TaskWidget(
                      title: createShortText(
                        index: index,
                        shortText: ShortText.title,
                        numberOfCharacters: 25,
                      ),
                      description: createShortText(
                        index: index,
                        shortText: ShortText.description,
                        numberOfCharacters: 50,
                      ),
                      color: tagColors[localListFilteredTasks[index].tag.color],
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
                    );
                  },
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
    );
  }
}
