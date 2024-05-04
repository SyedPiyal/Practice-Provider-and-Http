import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/comments.dart';

class CommentsService{
  
  Future<List<Comments>> getAllComments( ) async{
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as List;
      final commentss = json.map((e) {
        return Comments(
          postId: e['postId'],
          id: e['id'],
          name: e['name'],
          email: e['email'],
          body: e['body'],
        );
      },).toList();
      return commentss;
    }
    return [];
  }
  
}