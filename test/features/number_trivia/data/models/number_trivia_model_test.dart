import 'dart:convert';

import 'package:clean_architecture_with_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel('Test Text', 1);
  test('Should be a subclass of NumberTrivia Entity', () {
    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () {
        //arrange
        final Map<String, dynamic> json = jsonDecode(fixture('trivia.json'));
        //act
        final result = NumberTriviaModel.fromJson(json);
        //assert
        expect(result, tNumberTriviaModel);
      },
    );
    test(
      'should return a valid model when the JSON number is an double',
      () {
        //arrange
        final Map<String, dynamic> json = jsonDecode(fixture('trivia_double.json'));
        //act
        final result = NumberTriviaModel.fromJson(json);
        //assert
        expect(result, tNumberTriviaModel);
      },
    );
  });
  group('toJson', () {
    test('should return a JSON Map with proper data', () {
      //act
      final result = tNumberTriviaModel.toJson();
      //assert
      final Map<String, dynamic> expectedMap = {'text': 'Test Text', 'number': 1};
      expect(result, expectedMap);
    });
  });
}
