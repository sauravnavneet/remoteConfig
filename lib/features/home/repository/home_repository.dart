import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:interview_task/constants/urls.dart';
import 'package:interview_task/core/models/post_model.dart';

// provider for home respositry class
final homeRepositoryProvider = Provider((ref) => HomeRepository());

// stream to fetch post - returns post model
class HomeRepository {
  Stream<PostModel> fetchPosts() async* {
    try {
      final url = Uri.parse(BASE_URL);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List decodedData = jsonDecode(response.body);
        for (var item in decodedData) {
          yield PostModel.fromMap(item);
        }
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
