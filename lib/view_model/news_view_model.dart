
import 'package:news_app/models/NewsChannelHeadlinesModel.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {

  final _repo = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{
    final response = await _repo.fetchNewsChannelHeadlinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;
  }
}