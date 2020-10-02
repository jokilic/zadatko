import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './task.dart';
import './tag.dart';

// TODO: Implement Error enum
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

List<Task> listTasks = [];
List<Tag> listTags = [];

// Starting Tag
Tag allTag = Tag(
  title: 'All tasks',
  color: 0,
);

String uid;
DocumentReference user;
CollectionReference tasks;
CollectionReference tags;

class MyFirestore {
  //////////////////////////////////////
  /// INITIALIZE
  //////////////////////////////////////
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
      // TODO: Toast showing an erroro
      throw ('Error initializing Firebase: $e');
    }
  }

  Future<void> setDefaultValues() async {
    try {
      final DocumentSnapshot name = await user.get();
      if (!name.exists) await updateNameFirebase('someone');
    } catch (e) {
      // TODO: Toast showing an erroro
      throw ('Error setting default values: $e');
    }
  }

  //////////////////////////////////////
  /// NAME
  //////////////////////////////////////
  Future<String> getNameFirebase() async {
    try {
      final DocumentSnapshot name = await user.get();
      String newName = name.data()['name'];
      print('Name: $newName');
      return newName;
    } catch (e) {
      // TODO: Toast showing an erroro
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
      // TODO: Toast showing an erroro
      throw ('Error updating name: $e');
    }
  }

  //////////////////////////////////////
  /// TASKS
  //////////////////////////////////////
  Future<void> getTasksFirebase() async {
    try {
      final QuerySnapshot querySnapshot = await tasks.get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;

      listTasks = [];

      documents.forEach(
        (task) {
          listTasks.add(
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
      print('Number of tasks: ${listTasks.length}');
    } catch (e) {
      // TODO: Toast showing an erroro
      throw ('Error getting tasks: $e');
    }
  }

  Future<void> updateTaskFirebase(Task task) async {
    // TODO: Implement method
  }

  Future<void> createTaskFirebase(Task task) async {
    Map<String, dynamic> taskMap = {
      'title': task.title,
      'description': task.description ?? null,
      'tag': {
        'title': task.tag.title ?? null,
        'color': task.tag.color ?? null,
      },
      'isDone': task.isDone ?? false,
    };

    try {
      await tasks.add(taskMap);
      print('Task created successfully.');
    } catch (e) {
      // TODO: Toast showing an erroro
      throw ('Error creating Task: $e');
    }
  }

  //////////////////////////////////////
  /// TAGS
  //////////////////////////////////////
  Future<void> getTagsFirebase() async {
    try {
      final QuerySnapshot querySnapshot = await tags.get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;

      listTags = [];

      documents.forEach(
        (tag) {
          listTags.add(
            Tag(
              title: tag.data()['title'],
              color: tag.data()['color'],
            ),
          );
        },
      );
      print('Number of tags: ${listTags.length}');
    } catch (e) {
      // TODO: Toast showing an erroro
      throw ('Error getting tags: $e');
    }
  }

  Future<void> updateTagFirebase(Tag tag) async {
    // TODO: Implement method
  }

  Future<void> createTagFirebase(Tag tag) async {
    try {
      await tags.add({
        'title': tag.title,
        'color': tag.color,
      });
      print('Tag created successfully.');
    } catch (e) {
      // TODO: Toast showing an erroro
      throw ('Error creating Tag: $e');
    }
  }
}
