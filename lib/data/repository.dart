import 'package:xml_final/data/models/article.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/data/models/review_model.dart';
import 'package:xml_final/data/models/walker_request.dart';
import 'package:xml_final/data/server_api.dart';

import 'models/user.dart';

class Repository {
  final _serverApi = ServerAPI();
  Future<List<DogWalker>> getDogWalkers() async {
    final response = await _serverApi.getDogWalkers();
    return response;
  }

  Future<List<Article>> getArticles() async {
    final response = await _serverApi.getArticles();
    return response;
  }

  Future<String> postUser(
      String name, String email, String password, bool isDogWalker) async {
    final response =
        await _serverApi.registerUser(name, email, password, isDogWalker);
    return response;
  }

  Future<String> postWalkerRequest(WalkerRequest walkerRequest) async {
    final response = await _serverApi.postWalkerRequest(walkerRequest);
    return response;
  }

  Future<String> postDogWalker(DogWalker dogWalker) async {
    final response = await _serverApi.createDogWalker(dogWalker);
    return response;
  }

  Future<String> loginUser(String email, String password) async {
    final response = await _serverApi.loginUser(email, password);
    return response;
  }

  Future<List<ReviewModel>> getReviews(String walkerName) async {
    final response = await _serverApi.getReviews(walkerName);
    return response;
  }

  Future<User> getUser(String email) async {
    final response = await _serverApi.getUser(email);
    return response;
  }
}
