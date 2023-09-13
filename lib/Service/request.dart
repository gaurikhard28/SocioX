import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/NewsModel.dart';


class NewsService {
  Future<List<Article>> getNews() async {
    var response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2023-08-13&sortBy=publishedAt&apiKey=85d2a882fe5c43fcaf8a19b70e029c44'));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
     // print(body);
      List<dynamic> articlesJson = body['articles'];
      List<Article> articles = [];
      // print(body);
      for (var json in articlesJson) {
        articles.add(Article.fromJson(json));
        print(articles);
      }
        print(articles);
        return articles;

    } else {
      throw Exception('Failed to load news');
    }
  }
}