# Zadatko

**Zadatko** will be a simple application that offers the users to write their tasks, check them off, add tags on them and possibly more funcionality.

I'm creating it with **Flutter** & **Firebase**.
The users will need to login using their email & password.
Tasks will be stored in the cloud and they will be safe, even if the app gets uninstalled.

I'm making this app because I want to work with **Flutter** & **Firebase**.

## Current state of the app

### What works?
- [x] Login/Signup
- [x] Changing name
- [x] Adding tasks
- [x] Adding tags
- [x] Linking tags & tasks
- [x] Showing tasks by linked tab
- [x] `isDone` functionality

### What is planned?

**General work**

- [ ] Generate new colors for the tags
- [ ] Create icon for the app
- [ ] Create screenshots for the Play Store
- [ ] Build first production version of the app
- [x] Refactor code & write comments where needed
- [x] Check all imports - They have to be relative
- [x] Remove all `print` statements
- [x] Create multiple files for the Strings - Break up `constants.dart`
- [x] Refactor `constants.dart`
- [x] All strings go in `constants.dart`
- [x] Implement `isDone` functionality
- [x] Easier method of linking tags to tasks
- [x] Task shouldn't be added if the title is the same as any other task

**auth.dart**

- [x] Remove `print` statements and implement `throw` on errors

**my_firestore.dart**

- [ ] Implement `Error` enum
- [ ] Implement `SnackBar()` for each potential error
- [x] Implement `updateTagFirebase()`
- [x] Implement `deleteTagFirebase()`
- [x] Implement `updateTaskFirebase()`
- [x] Implement `deleteTaskFirebase()`
- [x] Implement `toggleIsDoneFirebase()`

**info_screen.dart**

- [ ] Implement `InfoScreen()`

**empty_tasks.dart**

- [ ] Implement illustration and some message

**tasks_screen.dart**

- [ ] Loading screen until everything gets loaded
- [ ] If there are no tasks, show some screen with illustration and message
- [ ] Put **Sign-out** button somewhere

## Quick screenshots

![Screenshot](https://raw.githubusercontent.com/jokilic/zadatko/master/screenshots/screenshot.png)
