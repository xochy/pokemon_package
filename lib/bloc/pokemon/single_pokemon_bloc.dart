import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_package/pokemon_package.dart';
import 'package:pokemon_package/repositories/pokemon_repository.dart';

part 'single_pokemon_event.dart';
part 'single_pokemon_state.dart';

class SinglePokemonBloc extends Bloc<SinglePokemonEvent, SinglePokemonState> {
  final PokemonRepository pokemonRepository;

  SinglePokemonBloc(this.pokemonRepository) : super(SinglePokemonInitial()) {
    on<SinglePokemonEvent>((event, emit) async {
      if (event is LoadSinglePokemon) {
        emit(SinglePokemonLoading());
        try {
          // Simulate a network call to fetch the Pokemon
          final pokemon = await pokemonRepository.fetchPokemonByName(
            event.name,
          );
          emit(SinglePokemonLoaded(pokemon: pokemon));
        } catch (e) {
          emit(SinglePokemonError(message: 'Failed to load Pokémon: $e'));
        }
      }
    });
  }
}
