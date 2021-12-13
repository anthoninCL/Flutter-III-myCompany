class NotAdminException implements Exception {
  @override
  String toString() {
    return "The user is not admin";
  }
}
