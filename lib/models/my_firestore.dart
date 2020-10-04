import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './task.dart';
import './tag.dart';
import '../constants/general.dart';
import '../constants/errors.dart';
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
  deleteTask,
  toggleTask,
  getTags,
  updateTag,
  createTag,
  deleteTag,
}

String uid;
DocumentReference user;
CollectionReference tasks;
CollectionReference tags;

// Initialize the 'Error' enum
Error error = Error.no;

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
      error = Error.initialize;
      throw (firestoreInitializeError);
    }
  }

  // If the user is logged in for the first time
  Future<void> setDefaultValues() async {
    try {
      final DocumentSnapshot name = await user.get();
      if (!name.exists) {
        firstStart = true;
        await updateNameFirebase('someone');
      }
    } catch (e) {
      error = Error.setDefault;
      throw (firestoreDefaultValuesError);
    }
  }

  ///////////////////////
  /// NAME
  ///////////////////////
  Future<String> getNameFirebase() async {
    try {
      final DocumentSnapshot name = await user.get();
      String newName = name.data()['name'];
      return newName;
    } catch (e) {
      error = Error.getName;
      throw (firestoreGettingNameError);
    }
  }

  Future<void> updateNameFirebase(String name) async {
    try {
      await user.set({
        'name': name,
      });
    } catch (e) {
      error = Error.updateName;
      throw (firestoreUpdatingNameError);
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

      // Store all tasks from Firebase in a local List of Tasks
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

      // Create a list used for filtering with all of the values from Firebase
      localListFilteredTasks = localListAllTasks;
    } catch (e) {
      error = Error.getTasks;
      throw (firestoreGettingTasksError);
    }
  }

  Future<void> createTaskFirebase(Task task) async {
    // Create a Map with all task keys and values
    Map<String, dynamic> taskMap = {
      'title': task.title,
      'description': task.description,
      'tag': {
        'title': task.tag.title,
        'color': task.tag.color,
      },
      'isDone': task.isDone,
    };

    // Add the task to Firebase
    try {
      await tasks.doc(taskMap['title']).set(taskMap);
    } catch (e) {
      error = Error.createTask;
      throw (firestoreCreatingTaskError);
    }
  }

  Future<void> updateTaskFirebase(Task oldTask, Task newTask) async {
    // Updating is done by deleting the old task, and creating the updated one
    try {
      // Delete the old task
      deleteTaskFirebase(oldTask);

      // Create the new task
      createTaskFirebase(newTask);
    } catch (e) {
      error = Error.updateTask;
      throw (firestoreUpdatingTaskError);
    }
  }

  Future<void> deleteTaskFirebase(Task task) async {
    try {
      await tasks.doc(task.title).delete();
    } catch (e) {
      error = Error.deleteTask;
      throw (firestoreDeletingTaskError);
    }
  }

  Future<void> toggleIsDoneFirebase(Task task) async {
    // Update the 'isDone' property to the new value
    try {
      await tasks.doc(task.title).update({
        'isDone': task.isDone,
      });
    } catch (e) {
      error = Error.toggleTask;
      throw (firestoreTogglingTaskError);
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

      // Store all tasks from Firebase in a local List of Tags
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
    } catch (e) {
      error = Error.getTags;
      throw (firestoreGettingTagsError);
    }
  }

  Future<void> createTagFirebase(Tag tag) async {
    try {
      await tags.doc(tag.title).set({
        'title': tag.title,
        'color': tag.color,
      });
    } catch (e) {
      error = Error.createTag;
      throw (firestoreCreatingTagsError);
    }
  }

  Future<void> updateTagFirebase(Tag tag) async {
    try {} catch (e) {
      error = Error.updateTag;
      throw (firestoreUpdatingTagError);
    }
  }

  Future<void> deleteTagFirebase(Tag tag) async {
    try {} catch (e) {
      error = Error.deleteTag;
      throw (firestoreDeletingTagError);
    }
  }
}
