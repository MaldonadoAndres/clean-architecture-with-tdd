import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_architecture_with_tdd/core/error/failure.dart';
import 'package:clean_architecture_with_tdd/core/usecases/usecase.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia extends UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params(this.number);
  @override
  List<Object> get props => [number];
}
