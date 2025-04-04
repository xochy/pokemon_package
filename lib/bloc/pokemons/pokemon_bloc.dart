import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_package/pokemon_package.dart';
import 'package:pokemon_package/repositories/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

// PokemonBloc is responsible for managing the state of the Pokemon list
// and handling events related to fetching Pokemon data.
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;

  PokemonBloc(this.pokemonRepository) : super(PokemonInitial()) {
    on<LoadPokemons>((event, emit) async {
      if (state is PokemonInitial) {
        emit(PokemonLoading());
        try {
          final pokemons = await pokemonRepository.fetchPokemons(
            event.offset,
            event.limit,
          );
          emit(
            PokemonLoaded(
              pokemons: pokemons,
              hasReachedMax: pokemons.length < event.limit,
            ),
          );
        } catch (e) {
          emit(PokemonError(message: e.toString()));
        }
      } else if (state is PokemonLoaded) {
        final currentState = state as PokemonLoaded;
        if (!currentState.hasReachedMax) {
          try {
            final pokemons = await pokemonRepository.fetchPokemons(
              event.offset,
              event.limit,
            );
            if (pokemons.isEmpty) {
              emit(currentState.copyWith(hasReachedMax: true));
            } else {
              emit(
                PokemonLoaded(
                  pokemons: currentState.pokemons + pokemons,
                  hasReachedMax: pokemons.length < event.limit,
                ),
              );
            }
          } catch (e) {
            emit(PokemonError(message: e.toString()));
          }
        }
      }
    });
  }
}
