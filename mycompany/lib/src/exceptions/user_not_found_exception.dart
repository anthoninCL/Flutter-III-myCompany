class UserNotFoundException implements Exception {
  @override
  String toString() {
    return "The user doesn't exist";
  }
}
