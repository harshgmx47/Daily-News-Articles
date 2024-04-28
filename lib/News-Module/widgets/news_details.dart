import 'package:daily_news_articles/utils/myColors.dart';
import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final String description;
  final bool isFav;

  const NewsDetailsPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.description,
    required this.isFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: MediaQuery.of(context).size.width * 0.080,
        title: const Text('Back'),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (imageUrl.isNotEmpty)
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(imageUrl)),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: null,
                          icon: Icon(
                            isFav == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: MyNewsColor.favIconColor,
                          ))),
                ],
              ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 16),
            // Text(
            //   description,
            //   textAlign: TextAlign.justify,
            // ),
            const SizedBox(height: 16),
            Text(
              content,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
