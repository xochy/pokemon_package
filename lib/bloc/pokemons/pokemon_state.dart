part of 'pokemon_bloc.dart';

sealed class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

final class PokemonInitial extends PokemonState {}

final class PokemonLoading extends PokemonState {}

final class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  final bool hasReachedMax;

  const PokemonLoaded({required this.pokemons, required this.hasReachedMax});

  PokemonLoaded copyWith({List<Pokemon>? pokemons, bool? hasReachedMax}) {
    return PokemonLoaded(
      pokemons: pokemons ?? this.pokemons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [pokemons];
}

final class PokemonError extends PokemonState {
  final String message;
  const PokemonError({required this.message});

  @override
  List<Object> get props => [message];
}
