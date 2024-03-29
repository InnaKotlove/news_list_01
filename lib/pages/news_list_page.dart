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
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
            'daily News ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            wordSpacing: 4,
          ),
        ),

        actions: const [
          Icon(Icons.ac_unit, size: 30),
          Icon(Icons.dark_mode_outlined, size: 30),
        ],
      ),
      body: FutureBuilder(
        future: futureResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Loading error, no news!',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                        builder: (context) =>  DetailPage(news: news),
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
