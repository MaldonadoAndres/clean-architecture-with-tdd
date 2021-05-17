import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:clean_architecture_with_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_with_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaLocalDataSourceImpl(client: mockHttpClient);
  });
  void setUpMockHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailed() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      jsonDecode(
        fixture('trivia.json'),
      ),
    );
    test(
      '''should perform a GET request on a URL 
      with number being the endpoint 
      and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        final uri = Uri.parse('http://numbersapi.com/$tNumber');
        verify(mockHttpClient
            .get(uri, headers: {'content-type': 'application/json'}));
      },
    );
    test(
      'should return [NumberTrivia] when Status Code is 200',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw [ServerException] when Status Code is different than 200',
      () async {
        // arrange
        setUpMockHttpClientFailed();
        // act
        final call = dataSource.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      jsonDecode(
        fixture('trivia.json'),
      ),
    );
    test(
      '''should perform a GET request on a URL 
      with random number being the endpoint 
      and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        dataSource.getRandomNumberTrivia();
        // assert
        final uri = Uri.parse('http://numbersapi.com/random');
        verify(mockHttpClient
            .get(uri, headers: {'content-type': 'application/json'}));
      },
    );
    test(
      'should return [NumberTrivia] when Status Code is 200',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw [ServerException] when Status Code is different than 200',
      () async {
        // arrange
        setUpMockHttpClientFailed();
        // act
        final call = dataSource.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
