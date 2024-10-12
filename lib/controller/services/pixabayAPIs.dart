import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pixbay_gallery/controller/services/APIsNKeys.dart';

class PixabayApi {
  int page = 1;

  PixabayApi();

  Future<List<dynamic>> fetchImages() async {
    final url = Uri.parse(
        'https://pixabay.com/api/?key=$pixabayAPIKey&image_type=photo&per_page=20&page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      page++;
      return data['hits'];
    } else {
      throw Exception('Failed to load images');
    }
  }
}
