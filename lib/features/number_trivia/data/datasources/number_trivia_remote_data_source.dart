import 'dart:convert';

import 'package:clean_architecture_with_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number}
  ///
  /// Throws [ServerException] for all error code
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random
  ///
  /// Throws [ServerException] for all error code
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaLocalDataSourceImpl({@required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final uri = Uri.parse(url);
    final response =
        await client.get(uri, headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
