![Header](https://raw.githubusercontent.com/jokilic/zadatko/master/screenshots/header.png)

# Zadatko 📋

📋 **Zadatko** is a simple task management application written in **Flutter**.

### Signup/Login

Tasks are stored in a **Firebase** database.\
When first opening the app, you will sign-up with an email & password so the tasks are linked with your account.\
If you throw your phone in the water or simply decide to get a new one, tasks will always wait for you to check them off.\
Just login with your credentials and get to working.

### Tags

Tasks can be linked with tags so you can group everything together.\
You can create a tag and put a fancy color on it.\
That way, tasks are much easier to handle and get done in a timely manner.

### Update

Tasks and tags can both be updated after they've been created.\
Just hold the task or tag and modify anything your heart desires.\
Everything gets seamlessly updated in the database.

### Delete

When you're done with the task, you can check it off or you can delete it altogether.\
Everything is flexible and easy to use.

**Thank you for using my task management app.**

### Zadatko can be downloaded from [HERE](https://play.google.com/store/apps/details?id=com.josipkilic.zadatko).
&nbsp;

![Multi](https://raw.githubusercontent.com/jokilic/zadatko/master/screenshots/multi.png)

## Current state of the app

### What works?
- [x] Login/Signup
- [x] Changing name
- [x] Adding tasks
- [x] Adding tags
- [x] Linking tags & tasks
- [x] Showing tasks by linked tab
- [x] *Task is done* functionality
- [x] Updating tags & tasks functionality
- [x] Deleting tags & tasks functionality

### What is planned?

**General work**

- [x] Sign & build first production version of the app
- [x] Create proper Readme file
- [x] Create screenshots for the Play Store
- [x] Create icon for the app
- [x] Generate new colors for the tags
- [x] Research & update Firestore Security Rules
- [x] Test on multiple screens and make modifications where needed
- [x] Implement `Error` enums & error messages
- [x] Multi-line description field
- [x] Refactor code & write comments where needed
- [x] Check all imports - They have to be relative
- [x] Remove all `print` statements
- [x] Refactor `constants.dart` into multiple files
- [x] All strings go in `constants.dart`
- [x] Implement `isDone` functionality
- [x] Easier method of linking tags to tasks
- [x] Task shouldn't be added if the title is the same as any other task

**auth.dart**

- [x] Remove `print` statements and implement `throw` on errors

**my_firestore.dart**

- [x] Implement `updateTagFirebase()`
- [x] Implement `deleteTagFirebase()`
- [x] Implement `updateTaskFirebase()`
- [x] Implement `deleteTaskFirebase()`
- [x] Implement `toggleIsDoneFirebase()`

**info_screen.dart**

- [x] Implement `InfoScreen()`
- [x] Put **Sign-out** button on the bottom

**tasks_screen.dart**

- [x] Shorten description text if it has multiple lines
- [x] Loading screen until everything gets loaded
- [x] If there are no tasks, show some screen with illustration and message

**zadatko_button.dart**

- [x] Implement possibility to put red border color on the button
