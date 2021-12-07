class InvalidEmailException implements Exception {
  String errorMessage() {
    return "The email used is invalid";
  }
}
