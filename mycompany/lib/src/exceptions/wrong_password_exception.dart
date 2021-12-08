class WrongPasswordException implements Exception {
  String errorMessage() {
    return "The password is incorrect";
  }
}
