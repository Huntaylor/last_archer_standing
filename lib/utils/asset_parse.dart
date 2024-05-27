mixin AssetParse {
  String tilesParse(String data) {
    return data.replaceAll('assets/tiles/', '');
  }

  String imageParse(String data) {
    return data.replaceAll('assets/images/', '');
  }

  String jsonPathParse(String data) {
    return data.replaceFirst('assets/', '');
  }
}
