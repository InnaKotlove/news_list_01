import 'package:flutter/material.dart';
import 'package:news_list01/api/api_request.dart';

import '../models/news_models.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final ApiRequest apiRequest = ApiRequest();
  late Future<List<NewsModels>> futureResponse;

  @override
  void initState() {
    super.initState();
    futureResponse = apiRequest.selectNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('daily News '),
      ),
      body: FutureBuilder(
        future: futureResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Loading error, no news!'),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('List is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final NewsModels news = snapshot.data![index];
                return Card(
                  child: Column(
                    children: [
                      Image.network(
                        news.urlToImage!,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
