import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_news_articles/News-Module/controller/article_controller.dart';
import 'package:daily_news_articles/News-Module/controller/tabs_screen_controller.dart';
import 'package:daily_news_articles/News-Module/widgets/news_details.dart';
import 'package:daily_news_articles/News-Module/widgets/slide_widget.dart';
import 'package:daily_news_articles/custom-widgets/custom_textStyle.dart';
import 'package:daily_news_articles/utils/myAssets.dart';
import 'package:daily_news_articles/utils/myColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);

  final articleController = Get.put(ArticleController());
  final tabsController = Get.put(TabsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              // News and Favorites tabs buttons
              Stack(
                children: [
                  Obx(
                    () => Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton.outlined(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            style: IconButton.styleFrom(
                              side: BorderSide.none,
                              backgroundColor:
                                  tabsController.newsTabSelected == true
                                      ? MyNewsColor.tabSelectionColor
                                      : MyNewsColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {
                              tabsController.isNewsTabSelected(true);
                              tabsController.isFavsTabSelected(false);
                            },
                            icon: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 35,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "News",
                                  style: CustomTextStyle.headline,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                          IconButton.outlined(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            style: IconButton.styleFrom(
                              side: BorderSide.none,
                              backgroundColor:
                                  tabsController.favsTabSelected == true
                                      ? MyNewsColor.tabSelectionColor
                                      : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {
                              tabsController.isNewsTabSelected(false);
                              tabsController.isFavsTabSelected(true);
                            },
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 35,
                                  color: MyNewsColor.favIconColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Favs",
                                  style: CustomTextStyle.headline,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // News tab content
              Obx(
                () => tabsController.newsTabSelected
                    ? Container(
                        height: size.height,
                        width: size.width,
                        decoration:
                            BoxDecoration(color: MyNewsColor.primaryColor),
                        child: articleController.articles.isNotEmpty
                            ? ListView.builder(
                                controller: articleController.scrollController,
                                itemCount: articleController.articles.length,
                                itemBuilder: (context, index) {
                                  final article =
                                      articleController.articles[index];

                                  return SlideMenu(
                                    menuItems: [
                                      Container(
                                        height: size.height * 0.0,
                                        decoration: BoxDecoration(
                                            color: MyNewsColor.favIconColor
                                                .withOpacity(0.5),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                        child: IconButton.outlined(
                                          color: MyNewsColor.favIconColor,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * .02,
                                          ),
                                          style: IconButton.styleFrom(
                                              side: BorderSide.none,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4))),
                                          onPressed: () {
                                            articleController.toggleFavorite(
                                                article, index);
                                            articleController.isFavoriteSelected
                                                .value = true;
                                            // articleController.isFavoriteSelected
                                            //     .value = article.isFavorite;
                                          },
                                          icon: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                article.isFavorite == true ||
                                                        articleController
                                                                .isFavoriteSelected
                                                                .value ==
                                                            true
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                size: 28,
                                                color: MyNewsColor.favIconColor,
                                              ),
                                              const Text(
                                                "Add to\n Favorite",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: CustomTextStyle.body,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(NewsDetailsPage(
                                          title: article.title,
                                          content: article.content,
                                          description: article.description,
                                          imageUrl: article.imageUrl,
                                          isFav: article.isFavorite,
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: MyNewsColor.primaryColor),
                                          height: size.height * 0.180,
                                          child: Card(
                                            elevation: 20,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight: Radius.circular(5),
                                              ),
                                            ),
                                            surfaceTintColor:
                                                MyNewsColor.primaryColor,
                                            child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              leading: article
                                                      .imageUrl.isNotEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            article.imageUrl,
                                                        placeholder: (context,
                                                                url) =>
                                                            Image.asset(Assets
                                                                .placeholder),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(Assets
                                                                .placeholder),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : Image.asset(
                                                      Assets.placeholder),
                                              title: Text(
                                                article.title,
                                                style: CustomTextStyle
                                                    .newsheadline,
                                              ),
                                              subtitle: Text(
                                                article.description,
                                                style: CustomTextStyle.body,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                      )
                    : Container(),
              ),

              // Favorites tab content
              Obx(
                () => tabsController.favsTabSelected
                    ? Container(
                        height: size.height,
                        width: size.width,
                        decoration:
                            BoxDecoration(color: MyNewsColor.primaryColor),
                        child: articleController.favList.isNotEmpty
                            ? ListView.builder(
                                controller: articleController.scrollController,
                                itemCount: articleController.favList.length,
                                itemBuilder: (context, index) {
                                  final article =
                                      articleController.favList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: MyNewsColor.primaryColor),
                                      height: size.height * 0.180,
                                      child: Card(
                                        elevation: 20,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        surfaceTintColor:
                                            MyNewsColor.primaryColor,
                                        child: Stack(
                                          children: [
                                            ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              leading: article
                                                      .imageUrl.isNotEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            article.imageUrl,
                                                        placeholder: (context,
                                                                url) =>
                                                            Image.asset(Assets
                                                                .placeholder),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(Assets
                                                                .placeholder),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : Image.asset(
                                                      Assets.placeholder),
                                              title: Text(
                                                article.title,
                                                style: CustomTextStyle
                                                    .newsheadline,
                                              ),
                                              subtitle: Text(
                                                article.description,
                                                style: CustomTextStyle.body,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // Align(
                                            //   child: Icon(
                                            //     article.isFavorite == true
                                            //         ? Icons.favorite
                                            //         : Icons.favorite_border,
                                            //     color: MyNewsColor.favIconColor,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
