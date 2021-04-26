import 'package:clean_architecture_with_tdd/features/number_trivia/data/models/number_trivia_model.dart';

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
