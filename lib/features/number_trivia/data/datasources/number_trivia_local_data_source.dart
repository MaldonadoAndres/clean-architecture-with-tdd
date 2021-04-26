import 'package:clean_architecture_with_tdd/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  ///Gets the cached [NumberTriviaModel] which was gottern the
  ///last time the user had an internet connection
  ///
  ///Throws [NoLocalDataException] if theres nothing cached
  Future<NumberTriviaModel> getLastTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}
