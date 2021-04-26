import 'package:clean_architecture_with_tdd/core/error/failure.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> execute({@required int number}) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
