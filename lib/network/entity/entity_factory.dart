class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (json == null) {
      return null;
    } else {
      return json;
    }
  }
}
