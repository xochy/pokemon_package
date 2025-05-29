import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_package/pokemon_package.dart';

void main() {
  group('Pokemon Model Tests', () {
    const mockPokemonJson = {
      'name': 'pikachu',
      'url': 'https://pokeapi.co/api/v2/pokemon/25/',
      'id': 25,
      'weight': 60,
      'height': 4,
      'sprites': {
        'front_default':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
      },
    };

    const expectedPokemon = Pokemon(
      name: 'pikachu',
      url: 'https://pokeapi.co/api/v2/pokemon/25/',
      id: 25,
      weight: 60,
      height: 4,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
    );

    test('should create Pokemon from JSON correctly', () {
      // Act
      final result = Pokemon.fromJson(mockPokemonJson);

      // Assert
      expect(result, equals(expectedPokemon));
      expect(result.name, equals('pikachu'));
      expect(result.id, equals(25));
      expect(result.weight, equals(60));
      expect(result.height, equals(4));
      expect(result.imageUrl, isNotNull);
    });

    test('should handle nullable fields correctly', () {
      // Arrange
      const minimalJson = {'name': 'test-pokemon'};

      // Act
      final result = Pokemon.fromJson(minimalJson);

      // Assert
      expect(result.name, equals('test-pokemon'));
      expect(result.url, isNull);
      expect(result.id, isNull);
      expect(result.weight, isNull);
      expect(result.height, isNull);
      expect(result.imageUrl, isNull);
    });

    test('should have correct props for Equatable', () {
      // Arrange
      const pokemon1 = Pokemon(name: 'pikachu', id: 25);
      const pokemon2 = Pokemon(name: 'pikachu', id: 25);
      const pokemon3 = Pokemon(name: 'charizard', id: 6);

      // Assert
      expect(pokemon1, equals(pokemon2));
      expect(pokemon1, isNot(equals(pokemon3)));
    });
  });
}
