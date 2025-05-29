import 'package:pokemon_package/pokemon_package.dart';

class TestHelpers {
  static const mockPokemonJson = {
    'name': 'pikachu',
    'id': 25,
    'weight': 60,
    'height': 4,
    'sprites': {
      'front_default': 'https://example.com/pikachu.png'
    }
  };

  static const mockPokemon = Pokemon(
    name: 'pikachu',
    id: 25,
    weight: 60,
    height: 4,
    imageUrl: 'https://example.com/pikachu.png',
  );

  static const mockPokemonListJson = '''
  {
    "results": [
      {
        "name": "bulbasaur",
        "url": "https://pokeapi.co/api/v2/pokemon/1/"
      },
      {
        "name": "ivysaur", 
        "url": "https://pokeapi.co/api/v2/pokemon/2/"
      }
    ]
  }
  ''';
}