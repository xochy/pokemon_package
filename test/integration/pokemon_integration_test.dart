import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_package/pokemon_package.dart';
import 'package:pokemon_package/repositories/pokemon_repository.dart';

void main() {
  group('Pokemon Integration Tests', () {
    late PokemonRepository repository;
    late SinglePokemonBloc bloc;

    setUp(() {
      repository = PokemonRepository();
      bloc = SinglePokemonBloc(repository);
    });

    tearDown(() {
      bloc.close();
    });

    test('should fetch real pokemon data from API and validate structure', () async {
      // Act
      final pokemon = await repository.fetchPokemonByName('pikachu');

      // Assert
      expect(pokemon, isA<Pokemon>());
      expect(pokemon.name, equals('pikachu'));
      expect(pokemon.id, isNotNull);
      expect(pokemon.weight, isNotNull);
      expect(pokemon.height, isNotNull);
      expect(pokemon.imageUrl, isNotNull);
      
      // Validate data types and ranges
      expect(pokemon.id, isA<int>());
      expect(pokemon.weight, isA<int>());
      expect(pokemon.height, isA<int>());
      expect(pokemon.id! > 0, isTrue);
      expect(pokemon.weight! > 0, isTrue);
      expect(pokemon.height! > 0, isTrue);
    });
  });
}