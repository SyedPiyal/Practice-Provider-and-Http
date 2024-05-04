

import 'package:flutter/cupertino.dart';
import 'package:practice_provider/service/comments_service.dart';
import '../model/comments.dart';

class CommentsProvider extends ChangeNotifier {
  final _service = CommentsService();
  bool isLoading = false;
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;

  Future<void> getAllComments() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAllComments();
    _comments = response;
    isLoading = false;

    notifyListeners();
  }
}