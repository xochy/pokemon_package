import 'dart:convert'; // Import for JSON decoding
import 'package:http/http.dart' as http;
import 'package:pokemon_package/pokemon_package.dart';

class PokemonRepository {
  // This class will handle the data fetching and caching logic for Pokémon data.
  // It will interact with the API and manage the local database if needed.

  // Fetch paginated Pokémon data
  Future<List<Pokemon>> fetchPokemons(int offset, int limit) async {
    // Implement API call to fetch Pokémon data
    final response = await http.get(
      Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=$limit',
      ),
    );
    if (response.statusCode == 200) {
      // Parse the response and return a list of Pokémon
      return parsePokemons(response.body);
    } else {
      throw Exception('Failed to load Pokémon data');
    }
  }

  // Example method to cache Pokémon data
  void cachePokemons(List<Pokemon> pokemons) {
    // Implement caching logic here
  }

  // Parse JSON response into a list of Pokemon objects
  List<Pokemon> parsePokemons(String responseBody) {
    final Map<String, dynamic> json = jsonDecode(responseBody);
    final List<dynamic> results =
        json['results']; // 'results' contains the list of Pokémon
    return results.map((pokemonJson) => Pokemon.fromJson(pokemonJson)).toList();
  }

  // Fetch Pokémon by name
  Future<Pokemon> fetchPokemonByName(String name) async {
  final response = await http.get(
    Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'),
  );
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return Pokemon.fromJson(json);
  } else {
    throw Exception('Pokémon not found');
  }
}
}
