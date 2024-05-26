import 'package:top_news/models/categories_news_model.dart';
import 'package:top_news/repository/news_repository.dart';
import '../models/news_channal_headlines_model.dart';

class NewsViewModel {

  final _repo = NewsRepository();

  Future<NewsChannalHeadlinesModel> fetchNewsChannalHeadlinesApi(String channelName) async {
    final response = await _repo.fetchNewsChannalHeadlinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;
  }

}

