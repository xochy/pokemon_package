part of 'pokemon_bloc.dart';

sealed class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemons extends PokemonEvent {
  final int offset;
  final int limit;

  const LoadPokemons({required this.offset, required this.limit});

  @override
  List<Object> get props => [offset, limit];
}
