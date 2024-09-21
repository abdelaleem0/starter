double? parseDynamicToDouble(x) {
  if (x is double) {
    return x;
  } else if (x is int) {
    return x.toDouble();
  } else {
    return null;
  }
}