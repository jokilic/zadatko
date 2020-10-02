import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import './components/task_widget.dart';
import './components/tag_widget.dart';
import './components/change_name.dart';
import './components/create_task.dart';
import '../../models/my_firestore.dart';

int chosenTag = 0;
bool firstStart = true;
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

    if (firstStart) getData();
    firstStart = false;
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkColor,
      body: Container(
        width: size.width,
        child: Column(
          children: [
            SizedBox(height: 84.0),
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
              'You have ${listTasks.length} tasks',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 28.0),
            ),
            SizedBox(height: 36.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 45.0,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: listTags.length,
                  itemBuilder: (context, index) => TagWidget(
                    title: listTags[index].title,
                    backgroundColor: chosenTag == index
                        ? lightColor
                        : tagColors[listTags[index].color],
                    textColor: chosenTag == index ? darkColor : lightColor,
                    onTap: () {
                      setState(() {
                        // If already selected Tag is pressed, show all tasks
                        // TODO: If 'chosenTag == null', show all tasks
                        chosenTag == index
                            ? chosenTag = null
                            : chosenTag = index;
                        print(chosenTag);
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: Stack(
                children: [
                  if (listTasks.isNotEmpty)
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) => TaskWidget(
                        title: listTasks[index].title,
                        description: listTasks[index].description,
                        color: tagColors[listTasks[index].tag.color],
                      ),
                    ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: FloatingActionButton(
                      // TODO: Ovdje namjesti da je odabrani tag asociran sa taskom
                      onPressed: () => createTask(context, () => print('Jooy')),
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
    );
  }
}
