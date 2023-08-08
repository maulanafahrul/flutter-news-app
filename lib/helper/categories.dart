import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class NewsForCategories {
  List<ArticleModel> news = [];

  Future<void> getNewsForCategory(String category) async {
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=97a2a82b43fc457081f8b36087930252";
    Uri uri = Uri.parse(url); // Konversi string URL menjadi objek Uri
    var response = await http.get(uri);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          String author = element['author'] ?? "Unknown Author";
          String content = element['content'] ?? "the content not uploaded";
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: author,
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: content);
          news.add(articleModel);
        }
      });
      print(news);
    }
  }
}
