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

### What is planned?

**General work**

- [ ] Implement `isDone` functionality
- [ ] All strings go in `constants.dart`
- [ ] Check all imports - They have to be relative
- [ ] Refactor `constants.dart`
- [ ] Remove all `print` statements
- [ ] Refactor code & write comments where needed
- [ ] Create icon for the app
- [ ] Create screenshots for the Play Store
- [ ] Build first production version of the app

**auth.dart**

- [ ] Remove `print` statements and implement `throw` on errors
**my_firestore.dart**
- [ ] Implement `Error` enum
- [ ] Implement `SnackBar()` for each potential error
- [ ] Implement `updateTaskFirebase()`
- [ ] Implement `updateTagFirebase()`
- [ ] Implement `deleteTaskFirebase()`
- [ ] Implement `deleteTagFirebase()`

**info_screen.dart**

- [ ] Implement `InfoScreen()`

**empty_tasks.dart**

- [ ] Implement illustration and some message

**tasks_screen.dart**

- [ ] Loading screen until everything gets loaded
- [ ] Put **Sign-out** button somewhere

## Quick screenshots

![Screenshot](https://raw.githubusercontent.com/jokilic/zadatko/master/screenshots/screenshot.png)
