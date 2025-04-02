import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/categories_news_model.dart';
import '../models/news_channal_headlines_model.dart';


// String apiKey = dotenv.env['API_KEY'] ?? '';

class NewsRepository {

  final String apiKey = dotenv.env['API_KEY'] ?? ''; 
  
  Future<NewsChannalHeadlinesModel> fetchNewsChannalHeadlinesApi(String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=${apiKey}';
    final response = await http.get(Uri.parse(url));
    // if (kDebugMode) {
    //   log(response.body);
    // }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannalHeadlinesModel.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?q=${category}&apiKey=${apiKey}';
    final response = await http.get(Uri.parse(url));
    // if (kDebugMode) {
    //   log(response.body);
    // }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }
}

