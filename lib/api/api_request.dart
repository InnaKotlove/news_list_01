import 'dart:convert';
import 'package:news_list01/models/news_models.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  Future<List<NewsModels>> selectNews() async {
    final http.Response response = await http.get(
      Uri.parse(
        'http://api.mediastack.com/v1/news?access_key=ddf6da89f3961874766b013a67ab0fd6',
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data ['data'] != null) {
        return data['data']
            .map<NewsModels>((item) => NewsModels.fromJson(item))
            .toList();
      } else {
        throw Exception('No news found');
      }
    } else {
      throw Exception('Error : ${response.reasonPhrase}');
    }
  }
}
