extension JsonMapping on Map<String, dynamic> {
  Map<String, dynamic> withoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }
}