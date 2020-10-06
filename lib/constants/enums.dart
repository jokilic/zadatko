// Show proper fields in the StartScreen
enum StartFieldsState {
  start,
  login,
  signup,
}

// Potential errors during Login
enum LoginState {
  loggedIn,
  userNotFound,
  wrongPassword,
  wrongEmail,
  generalError,
}

// Potential errors during Signup
enum SignupState {
  signedUp,
  accountExists,
  weakPassword,
  wrongEmail,
  generalError,
}

// Potential errors in 'my_firebase.dart'
enum MyFirebaseError {
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

// For shortening the title & description for tasks in the TasksScreen
enum ShortText {
  title,
  description,
}

// Potential errors in 'create_task.dart'
enum CreateTaskError {
  no,
  titleEmpty,
  titleSame,
  generalError,
}

// Potential errors in 'create_tag.dart'
enum CreateTagError {
  no,
  titleEmpty,
  titleSame,
  generalError,
}

// Potential errors in 'update_delete_task.dart'
enum UpdateDeleteTaskError {
  no,
  titleEmpty,
  titleSame,
  updateError,
  deleteError,
}

// Potential errors in 'update_delete_tag.dart'
enum UpdateDeleteTagError {
  no,
  titleEmpty,
  titleSame,
  updateError,
  deleteError,
  tagUsed,
}
