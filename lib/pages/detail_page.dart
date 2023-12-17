import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_list01/models/news_models.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final NewsModels news;
  const DetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text('detail Info'),
        actions: const [
          Icon(Icons.speaker_notes_rounded),
          Icon(Icons.ac_unit),
        ],
      ),
      body: Column(
        children: [
        Image.network(
        news.urlToImage!,
          errorBuilder: (BuildContext context, Object exception,
              StackTrace? stackTrace) {
            return const SizedBox.shrink();
          },
         ),
          const SizedBox(height: 12),

        Text(
          news.title!,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
         ),
       ),

          const SizedBox(height: 12),

          Text(news.description ?? ''),

          const SizedBox(height: 12),

          Text(
            DateFormat('dd/MM/yyyy').format(
              DateTime.parse(news.publishedAt!),
            ),
          ),

          const SizedBox(height: 12),

          TextButton(
            onPressed: () => goUrl(news.url),
            child: Text(news.url),
          ),
        ],
      ),
    );
  }

  void goUrl (String url) async {
    final Uri uri = Uri.parse(url);
await launchUrl (uri);
  }
}
