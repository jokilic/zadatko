import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './task.dart';
import './tag.dart';
import '../constants.dart';
import '../screens/tasks_screen/tasks_screen.dart';

enum Error {
  no,
  initialize,
  setDefault,
  getName,
  updateName,
  getTasks,
  updateTask,
  createTask,
  getTags,
  updateTag,
  createTag,
}

String uid;
DocumentReference user;
CollectionReference tasks;
CollectionReference tags;

class MyFirestore {
  ///////////////////////
  /// INITIALIZE
  ///////////////////////
  Future<void> initializeFirebase() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

      // Get the ID of the current user
      uid = auth.currentUser.uid;
      // Get User Document
      user = firestoreInstance.collection('users').doc(uid);
      // Get Tasks Collection
      tasks = user.collection('tasks');
      // Get Tags Collection
      tags = user.collection('tags');
    } catch (e) {
      throw ('Error initializing Firebase: $e');
    }
  }

  Future<void> setDefaultValues() async {
    try {
      final DocumentSnapshot name = await user.get();
      if (!name.exists) {
        firstStart = true;
        await updateNameFirebase('someone');
      }
    } catch (e) {
      throw ('Error setting default values: $e');
    }
  }

  ///////////////////////
  /// NAME
  ///////////////////////
  Future<String> getNameFirebase() async {
    try {
      final DocumentSnapshot name = await user.get();
      String newName = name.data()['name'];
      print('Name: $newName');
      return newName;
    } catch (e) {
      throw ('Error getting name: $e');
    }
  }

  Future<void> updateNameFirebase(String name) async {
    try {
      await user.set({
        'name': name,
      });
      print('Name updated successfully.');
    } catch (e) {
      throw ('Error updating name: $e');
    }
  }

  ///////////////////////
  /// TASKS
  ///////////////////////
  Future<void> getTasksFirebase() async {
    try {
      final QuerySnapshot querySnapshot = await tasks.get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;

      localListAllTasks = [];

      documents.forEach(
        (task) {
          localListAllTasks.add(
            Task(
              title: task.data()['title'],
              description: task.data()['description'],
              tag: Tag(
                title: task.data()['tag']['title'],
                color: task.data()['tag']['color'],
              ),
              isDone: task.data()['isDone'],
            ),
          );
        },
      );
      localListFilteredTasks = localListAllTasks;

      print('Number of tasks: ${localListAllTasks.length}');
    } catch (e) {
      throw ('Error getting tasks: $e');
    }
  }

  Future<void> createTaskFirebase(Task task) async {
    Map<String, dynamic> taskMap = {
      'title': task.title,
      'description': task.description,
      'tag': {
        'title': task.tag.title,
        'color': task.tag.color,
      },
      'isDone': task.isDone,
    };

    try {
      // Check if task with the same name exists
      final QuerySnapshot querySnapshot =
          await tasks.where('title', isEqualTo: task.title).get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;

      bool taskExists = false;

      documents.forEach((task) {
        String taskTitle = task.data()['title'];

        if (taskTitle == taskMap['title']) taskExists = true;
      });
      if (taskExists == false)
        // Add the task
        await tasks.doc(taskMap['title']).set(taskMap);
      else
        throw ('Task with the same name exists.');

      print('Task created successfully.');
    } catch (e) {
      throw ('Error creating Task: $e');
    }
  }

  Future<void> updateTaskFirebase(Task task) async {}

  Future<void> deleteTaskFirebase(Task task) async {}

  Future<void> toggleIsDoneFirebase(Task task) async {
    try {
      tasks.doc(task.title).update({
        'isDone': task.isDone,
      });

      print('Task toggled successfully.');
    } catch (e) {
      throw ('Error toggling Task: $e');
    }
  }

  ///////////////////////
  /// TAGS
  ///////////////////////
  Future<void> getTagsFirebase() async {
    try {
      final QuerySnapshot querySnapshot = await tags.get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;

      localListAllTags = [];

      documents.forEach(
        (tag) {
          localListAllTags.add(
            Tag(
              title: tag.data()['title'],
              color: tag.data()['color'],
            ),
          );
        },
      );
      print('Number of tags: ${localListAllTags.length}');
    } catch (e) {
      throw ('Error getting tags: $e');
    }
  }

  Future<void> createTagFirebase(Tag tag) async {
    try {
      await tags.doc(tag.title).set({
        'title': tag.title,
        'color': tag.color,
      });

      print('Tag created successfully.');
    } catch (e) {
      throw ('Error creating Tag: $e');
    }
  }

  Future<void> updateTagFirebase(Tag tag) async {}

  Future<void> deleteTagFirebase(Tag tag) async {}
}
