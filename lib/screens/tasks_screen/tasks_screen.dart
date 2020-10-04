import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import './components/task_widget.dart';
import './components/tag_widget.dart';
import './components/change_name.dart';
import './components/create_tag.dart';
import './components/create_task.dart';
import '../../models/my_firestore.dart';

enum ShortText {
  title,
  description,
}

bool firstStart = false;
int chosenTagMainScreen;
bool getDataBool = true;
MyFirestore firestore = MyFirestore();
String chosenName;

class TasksScreen extends StatefulWidget {
  static const routeName = '/tasks-screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();

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
                  'Hello, $chosenName',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 36.0),
                ),
              ),
              Text(
                'You have ${localListFilteredTasks.length} tasks',
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
                        onTap: () {
                          setState(() {
                            // If already selected Tag is pressed, show all tasks
                            chosenTagMainScreen == index
                                ? chosenTagMainScreen = null
                                : chosenTagMainScreen = index;
                          });

                          // If no tags are pressed, show all tasks
                          if (chosenTagMainScreen == null)
                            localListFilteredTasks = localListAllTasks;
                          else
                            // Filter tasks by the index of the chosen tag
                            localListFilteredTasks = localListAllTasks
                                .where(
                                  (task) =>
                                      task.tag.title ==
                                      localListAllTags[chosenTagMainScreen]
                                          .title,
                                )
                                .toList();
                        },
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
                          // Toggle the 'isDone' state of the tapped task
                          onTap: () {
                            setState(() {
                              localListFilteredTasks[index].isDone =
                                  !localListFilteredTasks[index].isDone;
                            });
                            firestore.toggleIsDoneFirebase(
                                localListFilteredTasks[index]);
                          },
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
