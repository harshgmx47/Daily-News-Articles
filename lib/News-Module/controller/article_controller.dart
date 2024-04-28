import 'dart:convert';
import 'dart:developer';
import 'package:daily_news_articles/News-Module/models/sucess_model.dart';
import 'package:daily_news_articles/custom-widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/news_article_model.dart';

class ArticleController extends GetxController {
  final articles = RxList<Article>([]);
  final favList = RxList<Article>();
  RxBool isFavoriteSelected = false.obs;

  RxBool isLoading = false.obs;
  final totalResults = 0.obs;

  int pageSize = 20; // number of items loaded per request
  RxInt page = 1.obs;
  ScrollController scrollController = ScrollController();
  Future<void> fetchArticles({String? date, bool? initial = false}) async {
    isLoading(true);
    update();
    date = "&from=2024-03-28&sortBy=publishedAt";
    // const apiKey = "8aa8f4f91bb5414cbe669cd59f08092a";
    const apiKey = "b06a21d89a0041a3b18845f0fa7c41a3";

    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla$date&language=en&apiKey=$apiKey&pageSize=$pageSize');
    print(url);
    try {
      final response =
          await http.get(url, headers: {"content-type": "application/json"});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        if (responseJson["status"] == "ok") {
          final articlesData = responseJson["articles"] as List;
          articles.value = articlesData
              .map((articleData) => Article.fromJson(articleData))
              .toList();

          isLoading(false);

          update();
          // Display success message as a SnackBar
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            CustomSnackbar.buildSnackBar(
              message: "Articles loaded successfully",
              context: Get.context!,
            ),
          );
        } else if (response.statusCode == 429) {
          // SuccessModel successModel =
          //     SuccessModel.fromJson(json.decode(response.body));

          ScaffoldMessenger.of(Get.context!).showSnackBar(
            CustomSnackbar.buildSnackBar(
              message: "Articles can't loaded requestLimit exceeds ",
              context: Get.context!,
            ),
          );

          log("Error: ${responseJson['message']}");
        }
      }
    } catch (e) {
      if (e is http.ClientException) {
        log("HTTP Client Exception: $e");
      } else {
        log("Error: $e");
      }
      throw Exception("Error fetching articles: $e");
    } finally {
      isLoading(false);
      update();
    }
  }

  void toggleFavorite(Article article, int index) {
    if (favList.contains(article)) {
      favList.remove(article);
      article.isFavorite = false;
      if (articles.contains(article)) {
        articles[index].isFavorite = false;
      }
    } else {
      favList.add(article);
      article.isFavorite = true;
      if (articles.contains(article)) {
        articles[index].isFavorite = true;
      }
    }
    update();
  }

  // ignore: non_constant_identifier_names
  void InitMethod() async {
    await fetchArticles();
    manageController();
  }

  void manageController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageSize += 20;
        // page.value++;
        fetchArticles(date: "", initial: false);
      }
    });
  }

  @override
  void onInit() {
    InitMethod();
    super.onInit();
  }
}
