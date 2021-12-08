class UserNotFoundException implements Exception {
  String errorMessage() {
    return "The user doesn't exist";
  }
}
