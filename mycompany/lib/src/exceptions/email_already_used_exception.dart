class EmailAlreadyUsedException implements Exception {
  @override
  String toString() {
    return "The account already exists for that email";
  }
}
