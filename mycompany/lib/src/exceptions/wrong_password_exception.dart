class WrongPasswordException implements Exception {
  @override
  String toString() {
    return "The password is incorrect";
  }
}
