extension MapWithOutNullValues<K, V> on Map {
  Map<K, V> get withOutNulls {
    Map<K, V> withOutNull = {};
    forEach((key, value) {
      if (value != null) {
        withOutNull.putIfAbsent(key, () => value);
      }
    });
    return withOutNull;
  }
}
