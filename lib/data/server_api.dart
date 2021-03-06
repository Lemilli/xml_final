import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/data/models/walker_request.dart';

import 'models/article.dart';
import 'models/review_model.dart';
import 'models/user.dart';

class ServerAPI {
  var dio = Dio();

  Future<List<DogWalker>> getDogWalkers() async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {
      'content-Type': 'text/xml',
    };
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    try {
      final url = kIsWeb
          ? 'http://localhost:4040/dog_walkers'
          : 'http://10.0.2.2:4040/dog_walkers';
      final response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      return dogWalkersFromXml(response.data);
    } on DioError catch (e) {
      print(e.message);
      return List.empty();
    } catch (e) {
      print('Exception unknown');
      return List.empty();
    }
  }

  Future<List<Article>> getArticles() async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {
      'content-Type': 'text/xml',
    };
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    try {
      final url = kIsWeb
          ? 'http://localhost:4040/articles'
          : 'http://10.0.2.2:4040/articles';
      final response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      // for testin
      return articlesFromXml(response.data);
    } on DioError catch (e) {
      print(e.message);
      return List.empty();
    } catch (e) {
      print('Exception unknown');
      return List.empty();
    }
  }

  Future<String> registerUser(
      String name, String email, String password, bool isDogWalker) async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {'content-Type': 'text/xml'};
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('user', nest: () {
      builder.element('name', nest: name);
      builder.element('email', nest: email);
      builder.element('password', nest: password);
      builder.element('is_dog_walker', nest: isDogWalker.toString());
    });

    final data = builder.buildDocument();
    print(data.toXmlString());

    try {
      final url =
          kIsWeb ? 'http://localhost:4040/user' : 'http://10.0.2.2:4040/user';

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 400) {
        return response.data.toString();
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        return 'Client Error. Try later.';
      } else if (response.statusCode! >= 500) return 'Server error';

      return '';
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      return 'Unknown Error';
    }
  }

  Future<String> postWalkerRequest(WalkerRequest _walkerRequest) async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {'content-Type': 'text/xml'};
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('walker_request', nest: () {
      builder.element('requester_email', nest: _walkerRequest.requesterEmail);
      builder.element('walker_name', nest: _walkerRequest.walkerName);
      builder.element('start_datetime',
          nest: _walkerRequest.startDatetime.toString());
      builder.element('end_datetime',
          nest: _walkerRequest.endDatetime.toString());
      builder.element('profit', nest: _walkerRequest.profit);
    });

    final data = builder.buildDocument();

    try {
      final url = kIsWeb
          ? 'http://localhost:4040/walker_request'
          : 'http://10.0.2.2:4040/walker_request';

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 400) {
        return response.data.toString();
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        return 'Client Error. Try later.';
      } else if (response.statusCode! >= 500) return 'Server error';

      return '';
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      return 'Unknown Error';
    }
  }

  Future<String> createDogWalker(DogWalker dogWalker) async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {'content-Type': 'text/xml'};
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('dog_walker', nest: () {
      builder.element('name', nest: dogWalker.name);
      builder.element('rating', nest: dogWalker.rating);
      builder.element('price', nest: dogWalker.price);
      builder.element('age', nest: dogWalker.age);
      builder.element('experience', nest: dogWalker.experience);
      builder.element('description', nest: dogWalker.description);
      builder.element('image_link', nest: dogWalker.imageLink);
      builder.element('walks_count', nest: dogWalker.walksCount);
    });

    final data = builder.buildDocument();

    try {
      final url = kIsWeb
          ? 'http://localhost:4040/post_dog_walker'
          : 'http://10.0.2.2:4040/post_dog_walker';

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 400) {
        return response.data.toString();
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        return 'Client Error. Try later.';
      } else if (response.statusCode! >= 500) return 'Server error';

      return '';
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      return 'Unknown Error';
    }
  }

  Future<String> loginUser(String email, String password) async {
    dio.options.headers = {
      'content-Type': 'text/xml',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
    };
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('user', nest: () {
      builder.element('email', nest: email);
      builder.element('password', nest: password);
    });

    final data = builder.buildDocument();

    try {
      final url =
          kIsWeb ? 'http://localhost:4040/login' : 'http://10.0.2.2:4040/login';

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 422) {
        return response.data.toString();
      } else if (response.statusCode! > 400 && response.statusCode! < 500) {
        return 'Client Error. Try later.';
      } else if (response.statusCode! >= 500)
        return 'Server error';
      else {
        return '';
      }
    } on DioError catch (e) {
      return e.message;
    } catch (e) {
      return 'Unknown Error';
    }
  }

  Future<List<ReviewModel>> getReviews(String walkerName) async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {'content-Type': 'text/xml'};
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    try {
      final url = kIsWeb
          ? 'http://localhost:4040/reviews?name=' + walkerName
          : 'http://10.0.2.2:4040/reviews?name=' + walkerName;
      final response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 400) {
        return List.empty();
      }

      return reviewsFromXml(response.data);
    } on DioError catch (e) {
      print(e.message);
      return List.empty();
    } catch (e) {
      print('Exception unknown');
      return List.empty();
    }
  }

  Future<List<WalkerRequest>> getWalkerRequests(String walkerName) async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {'content-Type': 'text/xml'};
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    try {
      final url = kIsWeb
          ? 'http://localhost:4040/get_walker_requests?name=' + walkerName
          : 'http://10.0.2.2:4040/get_walker_requests?name=' + walkerName;
      final response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 400) {
        return List.empty();
      }

      return walkerRequestsXml(response.data);
    } on DioError catch (e) {
      print(e.message);
      return List.empty();
    } catch (e) {
      print('Exception unknown');
      return List.empty();
    }
  }

  Future<User> getUser(String email) async {
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = {'content-Type': 'text/xml'};
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    try {
      final url = kIsWeb
          ? 'http://localhost:4040/get_user?email=' + email
          : 'http://10.0.2.2:4040/get_user?email=' + email;
      final response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      return userFromXml(response.data);
    } on DioError catch (e) {
      print(e.message);
      return User.empty();
    } catch (e) {
      print('Exception unknown');
      return User.empty();
    }
  }
}
