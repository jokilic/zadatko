///////////////////////
// ERRORS
///////////////////////

// auth.dart
const String authUserNotFound = 'User not registered yet.';
const String authPasswordWrong = 'You have entered a wrong password.';
const String authLoginError = 'Unable to log in.';
const String authPasswordWeak = 'The password provided is too weak.';
const String authEmailInUse = 'The account already exists for that email.';
const String authSignupError = 'Unable to sign up.';
const String authSignoutError = 'Unable to sign out.';

// my_firestore.dart
const String firestoreInitializeError = 'Error initializing Firebase.';
const String firestoreDefaultValuesError = 'Error getting default values.';
const String firestoreGettingNameError = 'Error getting name.';
const String firestoreUpdatingNameError = 'Error updating name.';
const String firestoreGettingTasksError = 'Error getting tasks.';
const String firestoreCreatingTaskError = 'Error creating task.';
const String firestoreUpdatingTaskError = 'Error updating task.';
const String firestoreDeletingTaskError = 'Error deleting task.';
const String firestoreTogglingTaskError = 'Error toggling task.';
const String firestoreGettingTagsError = 'Error getting tags.';
const String firestoreCreatingTagsError = 'Error creating tags.';
const String firestoreUpdatingTagError = 'Error updating tag.';
const String firestoreDeletingTagError = 'Error deleting tag.';

// start_screen.dart
const String loginUserNotFoundString = 'Usero not foundo.';
const String loginWrongPasswordString = 'Passwordo is wrongo.';
const String signupAccountExistsString = 'Accounto already existando.';
const String signupWeakPasswordString = 'Passwordo not strongo enough.';
const String signupGeneralErrorString = 'Accounto already existando.';
const String generalErrorString = 'Erroro has happendo.';
const String wrongEmailString = 'Emailo no correcto.';

// create_tag.dart
const String createTagErrorString = 'Error creating tag.';
const String tagTitleEmptyErrorString = 'Tag title is empty.';
const String tagSameNameErrorString =
    'There is already a tag with the same name.';

// create_task.dart
const String createTaskErrorString = 'Error creating task.';
const String taskTitleEmptyErrorString = 'Task title is empty.';
const String taskSameNameErrorString =
    'There is already a task with the same name.';

// update_delete_task.dart
const String updateTaskErrorString = 'Error updating task.';
const String deleteTaskErrorString = 'Error deleting task.';

// update_delete_tag.dart
const String updateTagErrorString = 'Error updating tag.';
const String deleteTagErrorString = 'Error deleting tag.';
const String tagUserErrorString = 'Tag is used, remove it from all tasks.';
