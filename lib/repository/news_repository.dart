import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/NewsChannelHeadlinesModel.dart';
import 'package:news_app/models/categories_news_model.dart';

class NewsRepository {

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=c2adbe7cb6814371807dd6872854060e' ;
    print(url);

    final response = await http.get(Uri.parse(url));

    if(kDebugMode){
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }else{
      throw Exception('Error');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=c2adbe7cb6814371807dd6872854060e' ;
    print(url);

    final response = await http.get(Uri.parse(url));

    if(kDebugMode){
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }else{
      throw Exception('Error');
    }
  }


}