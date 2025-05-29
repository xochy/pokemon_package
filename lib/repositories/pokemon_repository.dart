import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_package/pokemon_package.dart';

class PokemonRepository {
  // 1. Declara una propiedad pública para el cliente HTTP.
  http.Client httpClient;

  // 2. Crea un constructor que acepte un `http.Client` opcional.
  // Si no se proporciona un cliente (en producción), se crea una instancia nueva.
  // Si se proporciona (en pruebas), se usa esa instancia.
  PokemonRepository({http.Client? client})
    : httpClient = client ?? http.Client();

  // Fetch paginated Pokémon data
  Future<List<Pokemon>> fetchPokemons(int offset, int limit) async {
    // 3. Usa la instancia `httpClient` en lugar de la llamada estática.
    final response = await httpClient.get(
      Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=$limit',
      ),
    );
    if (response.statusCode == 200) {
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
    final List<dynamic> results = json['results'];
    return results.map((pokemonJson) => Pokemon.fromJson(pokemonJson)).toList();
  }

  // Fetch Pokémon by name
  Future<Pokemon> fetchPokemonByName(String name) async {
    // 4. Usa la instancia `httpClient` aquí también.
    final response = await httpClient.get(
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
