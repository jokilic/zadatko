import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import './components/task_widget.dart';
import './components/tag_widget.dart';

int chosenTag = 0;

class TasksScreen extends StatefulWidget {
  static const routeName = '/tasks-screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
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
            Text(
              'Hello, Josip',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 36.0),
            ),
            Text(
              'You have 5 tasks',
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
                  itemCount: tags.length,
                  itemBuilder: (context, index) => TagWidget(
                    title: tags[index].title,
                    backgroundColor:
                        chosenTag == index ? Colors.white : tags[index].color,
                    textColor: chosenTag == index ? darkColor : lightColor,
                    onTap: () {
                      setState(() {
                        chosenTag = index;
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
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      TaskWidget(
                        title: 'Igrati se s bubamarama.',
                        description:
                            'Nađi par bubamara u vrtu i igraj se s njima.',
                        checkbox: checkboxCheckedIcon,
                        color: Colors.red[300],
                        isDone: false,
                      ),
                      TaskWidget(
                        title: 'Otuširati se.',
                        description:
                            'Bilo bi dobro da se otuširaš, sumnjiv si...',
                        checkbox: checkboxUncheckedIcon,
                        color: Colors.green[300],
                        isDone: false,
                      ),
                      TaskWidget(
                        title: 'Gledati zvijezde.',
                        description:
                            'Trebao bi gledati zvijezde malo, zato jer su lijepe.',
                        checkbox: checkboxCheckedIcon,
                        color: Colors.purple[300],
                        isDone: false,
                      ),
                      SizedBox(height: 56.0),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: FloatingActionButton(
                      onPressed: () => print('Hej'),
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
