class WeakPasswordException implements Exception {
  String errorMessage() {
    return "The password provided is too weak.";
  }
}
