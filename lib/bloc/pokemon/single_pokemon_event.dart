part of 'single_pokemon_bloc.dart';

sealed class SinglePokemonEvent extends Equatable {
  const SinglePokemonEvent();

  @override
  List<Object> get props => [];
}

class LoadSinglePokemon extends SinglePokemonEvent {
  final String name;

  const LoadSinglePokemon({required this.name});

  @override
  List<Object> get props => [name];
}
