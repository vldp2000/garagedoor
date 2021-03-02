import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<int> getDoorState(String url, int doorId) async {
    var response = await http.get('$url/state/$doorId');

    var json = jsonDecode(response.body);

    var result = json["sensor"];

    return result;
  }

  Future<bool> toggleDoor(String url, int doorId) async {
    var response = await http.get('$url/toggle/$doorId');

    var json = jsonDecode(response.body);

    return json["status"] == "success" ? true : false;
  }

  //   // Convert and return
  //   return User.fromJson(json.decode(response.body));
  // }

  // Future<List<Post>> getPostsForUser(int userId) async {
  //   var posts = List<Post>();
  //   // Get user posts for id
  //   var response = await client.get('$endpoint/posts?userId=$userId');

  //   // parse into List
  //   var parsed = json.decode(response.body) as List<dynamic>;

  //   // loop and convert each item to Post
  //   for (var post in parsed) {
  //     posts.add(Post.fromJson(post));
  //   }

  //   return posts;
  // }

  // Future<List<Comment>> getCommentsForPost(int postId) async {
  //   var comments = List<Comment>();

  //   // Get comments for post
  //   var response = await client.get('$endpoint/comments?postId=$postId');

  //   // Parse into List
  //   var parsed = json.decode(response.body) as List<dynamic>;

  //   // Loop and convert each item to a Comment
  //   for (var comment in parsed) {
  //     comments.add(Comment.fromJson(comment));
  //   }

  //   return comments;
  // }
}
