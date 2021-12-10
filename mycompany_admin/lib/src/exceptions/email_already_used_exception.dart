class EmailAlreadyUsedException implements Exception {
  String errorMessage() {
    return "The account already exists for that email";
  }
}
