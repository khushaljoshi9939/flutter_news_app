import 'dart:convert';

import 'package:knews/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> newsList = [];

  void getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=a083f0f615344ddf9e591e8dd9eae095";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((e) {
        if (e["urlToImage"] != null && e["description"] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: e["title"],
            url: e["url"],
            content: e["content"],
            desc: e["description"],
            urlImage: e["urlToImage"],
          );

          newsList.add(articleModel);
        }
      });
    }
  }
}

class CatogryNews {
  List<ArticleModel> newsList = [];

  void getNews(String c) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$c&apiKey=a083f0f615344ddf9e591e8dd9eae095";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((e) {
        if (e["urlToImage"] != null && e["description"] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: e["title"],
            url: e["url"],
            content: e["content"],
            desc: e["description"],
            urlImage: e["urlToImage"],
          );

          newsList.add(articleModel);
        }
      });
    }
  }
}
