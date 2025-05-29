import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_package/pokemon_package.dart';
import 'package:pokemon_package/repositories/pokemon_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('PokemonRepository Tests', () {
    late PokemonRepository repository;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      repository = PokemonRepository();
      // Inyectar el mock client si tu repositorio lo permite
      repository.httpClient = mockHttpClient;
    });

    group('fetchPokemonByName', () {
      const pokemonName = 'pikachu';
      const mockResponse = '''
      {
        "name": "pikachu",
        "id": 25,
        "weight": 60,
        "height": 4,
        "sprites": {
          "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
        }
      }
      ''';

      test('should return Pokemon when API call is successful', () async {
        // Arrange
        when(
          () => mockHttpClient.get(
            Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'),
          ),
        ).thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await repository.fetchPokemonByName(pokemonName);

        // Assert
        expect(result, isA<Pokemon>());
        expect(result.name, equals('pikachu'));
        expect(result.id, equals(25));
        expect(result.weight, equals(60));
        expect(result.height, equals(4));
        expect(result.imageUrl, isNotNull);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        when(
          () => mockHttpClient.get(
            Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(
          () async => await repository.fetchPokemonByName(pokemonName),
          throwsA(isA<Exception>()),
        );
      });

      test('should throw exception when network error occurs', () async {
        // Arrange
        when(
          () => mockHttpClient.get(
            Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'),
          ),
        ).thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () async => await repository.fetchPokemonByName(pokemonName),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('fetchPokemons', () {
      const mockListResponse = '''
      {
        "results": [
          {
            "name": "bulbasaur",
            "url": "https://pokeapi.co/api/v2/pokemon/1/"
          },
          {
            "name": "ivysaur",
            "url": "https://pokeapi.co/api/v2/pokemon/2/"
          }
        ]
      }
      ''';

      test(
        'should return list of Pokemon when API call is successful',
        () async {
          // Arrange
          when(
            () => mockHttpClient.get(
              Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20'),
            ),
          ).thenAnswer((_) async => http.Response(mockListResponse, 200));

          // Act
          final result = await repository.fetchPokemons(0, 20);

          // Assert
          expect(result, isA<List<Pokemon>>());
          expect(result.length, equals(2));
          expect(result[0].name, equals('bulbasaur'));
          expect(result[1].name, equals('ivysaur'));
        },
      );
    });
  });
}
