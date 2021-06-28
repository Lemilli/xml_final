import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/data/server_api.dart';

class Repository {
  final _serverApi = ServerAPI();
  Future<List<DogWalker>> getDogWalkers() async {
    final response = await _serverApi.getDogWalkers();
    return response;
  }

  Future<String> postUser(String name, String email, String password) async {
    final response = await _serverApi.registerUser(name, email, password);
    return response;
  }
}
