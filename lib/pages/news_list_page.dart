import 'package:flutter/material.dart';
import 'package:news_list01/api/api_request.dart';
import 'package:news_list01/pages/detail_page.dart';
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
                return InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailPage( ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    margin: const EdgeInsets.symmetric(),
                    child: Column(
                      children: [
                        Image.network(
                          news.urlToImage!,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            news.title!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(news.description ?? ''),
                        )
                      ],
                    ),
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
