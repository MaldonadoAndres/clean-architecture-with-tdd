import 'package:dartz/dartz.dart';

import 'package:clean_architecture_with_tdd/core/error/failure.dart';
import 'package:clean_architecture_with_tdd/core/usecases/usecase.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTrivia(this.numberTriviaRepository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams _) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}