class News {
  var newsArray = <News>[];
  var queryArray = <News>[];
  String title;
  String category;
  String imageUrl;
  String link;
  News([this.title, this.category, this.imageUrl, this.link]);

  var newsList = <News>[];

  Future queryTitle(String query) async {
    if (query.length > 0) {
      queryArray.clear();
      newsArray.forEach((element) {
        element.title.contains(query) ? queryArray.add(element) : null;
      });
    }
  }

  Future queryList(String query) async {
    if (query.length > 0) {
      queryArray.clear();
      newsArray.forEach((element) {
        element.title.split(" ")[0].toString() == query
            ? queryArray.add(element)
            : null;
      });
    }
  }
}
