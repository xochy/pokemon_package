import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_package/pokemon_package.dart';
import 'package:pokemon_package/repositories/pokemon_repository.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  group('SinglePokemonBloc Tests', () {
    late SinglePokemonBloc bloc;
    late MockPokemonRepository mockRepository;

    const mockPokemon = Pokemon(
      name: 'pikachu',
      id: 25,
      weight: 60,
      height: 4,
      imageUrl: 'https://example.com/pikachu.png',
    );

    setUp(() {
      mockRepository = MockPokemonRepository();
      bloc = SinglePokemonBloc(mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state should be SinglePokemonInitial', () {
      expect(bloc.state, equals(SinglePokemonInitial()));
    });

    group('LoadSinglePokemon Event', () {
      blocTest<SinglePokemonBloc, SinglePokemonState>(
        'should emit [Loading, Loaded] when repository returns pokemon successfully',
        build: () {
          when(() => mockRepository.fetchPokemonByName('pikachu'))
              .thenAnswer((_) async => mockPokemon);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadSinglePokemon(name: 'pikachu')),
        expect: () => [
          SinglePokemonLoading(),
          const SinglePokemonLoaded(pokemon: mockPokemon),
        ],
        verify: (_) {
          verify(() => mockRepository.fetchPokemonByName('pikachu')).called(1);
        },
      );

      blocTest<SinglePokemonBloc, SinglePokemonState>(
        'should emit [Loading, Error] when repository throws exception',
        build: () {
          when(() => mockRepository.fetchPokemonByName('invalid-pokemon'))
              .thenThrow(Exception('Pokémon not found'));
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadSinglePokemon(name: 'invalid-pokemon')),
        expect: () => [
          SinglePokemonLoading(),
          const SinglePokemonError(message: 'Failed to load Pokémon: Exception: Pokémon not found'),
        ],
        verify: (_) {
          verify(() => mockRepository.fetchPokemonByName('invalid-pokemon')).called(1);
        },
      );

      blocTest<SinglePokemonBloc, SinglePokemonState>(
        'should emit [Loading, Error] when network error occurs',
        build: () {
          when(() => mockRepository.fetchPokemonByName('pikachu'))
              .thenThrow(Exception('Network error'));
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadSinglePokemon(name: 'pikachu')),
        expect: () => [
          SinglePokemonLoading(),
          const SinglePokemonError(message: 'Failed to load Pokémon: Exception: Network error'),
        ],
      );

      blocTest<SinglePokemonBloc, SinglePokemonState>(
        'should validate that loaded pokemon has expected properties',
        build: () {
          when(() => mockRepository.fetchPokemonByName('pikachu'))
              .thenAnswer((_) async => mockPokemon);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadSinglePokemon(name: 'pikachu')),
        expect: () => [
          SinglePokemonLoading(),
          const SinglePokemonLoaded(pokemon: mockPokemon),
        ],
        verify: (_) {
          final state = bloc.state as SinglePokemonLoaded;
          expect(state.pokemon.name, equals('pikachu'));
          expect(state.pokemon.id, equals(25));
          expect(state.pokemon.weight, equals(60));
          expect(state.pokemon.height, equals(4));
          expect(state.pokemon.imageUrl, isNotNull);
        },
      );
    });
  });
}