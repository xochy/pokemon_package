part of 'single_pokemon_bloc.dart';

sealed class SinglePokemonState extends Equatable {
  const SinglePokemonState();
  
  @override
  List<Object> get props => [];
}

final class SinglePokemonInitial extends SinglePokemonState {}

final class SinglePokemonLoading extends SinglePokemonState {}

final class SinglePokemonLoaded extends SinglePokemonState {
  final Pokemon pokemon;

  const SinglePokemonLoaded({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

final class SinglePokemonError extends SinglePokemonState {
  final String message;
  const SinglePokemonError({required this.message});

  @override
  List<Object> get props => [message];
}
