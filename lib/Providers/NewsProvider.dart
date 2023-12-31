import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_x/Service/request.dart';

import '../Models/NewsModel.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  NewsService newsService=NewsService();
  bool _isOffline = false;
  bool _onLoad = false;
  List<String> searchList = [];
  List<Article> previousList=[];


  List<Article> get articles => _articles;
  bool get isOffline => _isOffline;
  bool get onLoad => _onLoad;

  void setArticles(List<Article> articles) {
    _articles = articles;

    notifyListeners();
  }

  void setIsOffline(bool isOffline) {
    _isOffline = isOffline;
    notifyListeners();
  }

  void setOnLoad(bool value) {
    _onLoad = value;
    notifyListeners();
  }

  void loadArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? previousArticles = prefs.getString("articles");
    if (previousArticles != null) {
      List<dynamic> previousListItems = jsonDecode(previousArticles);
      previousList = List<Article>.from(
        previousListItems.map((item) => Article.fromJson(item)),
      );
    }
  }

  List<Article> searchNews(String searchTerm) {
    List<Article> searchResults = [];
    RegExp regex = RegExp(searchTerm, caseSensitive: false);
    for (Article article in _articles) {
      if (regex.hasMatch(article.title ?? '')) {
        searchResults.add(article);
      }
    }
    return searchResults;
  }

  Future<void> getNews() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setOnLoad(true);
      List<Article> newArticles = await newsService.getNews();
      //print(newArticles);
      _articles.addAll(newArticles);
      sharedPreferences.setString("articles", jsonEncode(_articles));
      setOnLoad(false);
    } catch (e) {
      setOnLoad(false);
      print('Error fetching news: $e');
    }
    notifyListeners();
  }
}
