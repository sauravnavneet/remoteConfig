import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/core/models/post_model.dart';
import 'package:interview_task/features/home/repository/home_repository.dart';

// stream post provider to get list of post model
final postProvider = StreamProvider<List<PostModel>>((ref) async* {
  final homeRepository = ref.watch(homeRepositoryProvider);
  List<PostModel> postList = [];
  await for (var post in homeRepository.fetchPosts()) {
    postList.add(post);
    yield postList;
  }
});
