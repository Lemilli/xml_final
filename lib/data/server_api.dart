import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';
import 'package:xml_final/data/models/dog_walker.dart';

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

  Future<String> registerUser(
      String name, String email, String password) async {
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
    });

    final data = builder.buildDocument();

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
          ? 'http://localhost:4040/reviews'
          : 'http://10.0.2.2:4040/reviws';
      final response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      return reviewsFromXml(response.data);
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
