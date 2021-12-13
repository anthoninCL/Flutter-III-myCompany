class InvalidEmailException implements Exception {
  @override
  String toString() {
    return "The email used is invalid";
  }
}
