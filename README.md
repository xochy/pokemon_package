# 📦 pokemon_package

## 1. 📝 Descripción del paquete

`pokemon_package` es un **micro paquete independiente** diseñado para manejar la lógica de datos de una aplicación Flutter que consume la [PokéAPI](https://pokeapi.co/).  

Este paquete encapsula:
- 📌 **Modelos de datos** para representar Pokémon y sus atributos.
- 🌍 **Llamadas HTTP** para obtener información de la PokéAPI.
- ⚡ **Funcionalidades reutilizables**, como:
  - Manejo de errores en solicitudes HTTP.
  - Soporte para **paginación** al obtener listas de Pokémon.

Este enfoque modular permite que `pokemon_package` sea **reutilizado en múltiples aplicaciones** sin modificar su código base.

---

## 2. 🚀 Instalación

Para usar `pokemon_package` en tu proyecto Flutter, agrégalo como dependencia en el archivo `pubspec.yaml`:

```yaml
dependencies:
  pokemon_package:
    git:
      url: https://github.com/tu_usuario/pokemon_package.git
```

### 📦 Instalar dependencias:
```bash
flutter pub get
```

## 3. 🔗 Uso del paquete

### 📌 1. Importar el paquete en tu código:
```bash
import 'package:pokemon_package/pokemon_package.dart';
```

### 📌 2. Obtener la lista de Pokémon (con paginación):
```bash
final repository = PokemonRepository();

Future<void> fetchPokemons() async {
  try {
    final pokemonList = await repository.getPokemonList(limit: 20, offset: 0);
    print("Pokémon obtenidos: ${pokemonList.length}");
  } catch (e) {
    print("Error al obtener los Pokémon: $e");
  }
}
```

### 📌 3. Obtener detalles de un Pokémon por nombre:
```bash
Future<void> fetchPokemonDetails() async {
  try {
    final pokemon = await repository.getPokemonByName("pikachu");
    print("Detalles de Pikachu: ${pokemon.name}, ID: ${pokemon.id}");
  } catch (e) {
    print("Error al obtener detalles: $e");
  }
}
```

## 4. 🏗️ Arquitectura del paquete
### 📂 Estructura del paquete:
```bash
.
└── lib/
    ├── bloc/
    │   ├── pokemon/ # bloc de pokémon
    │   │   ├── single_pokemon_bloc.dart
    │   │   ├── single_pokemon_event.dart
    │   │   └── single_pokemon_state.dart
    │   └── pokemons/ # bloc de lista de pokémons
    │       ├── pokemon_bloc.dart
    │       ├── pokemon_event.dart
    │       └── pokemon_state.dart
    ├── models/
    │   └── pokemon.dart # Modelo de Pokémon
    ├── repositories/
    │   └── pokemon_repository.dart # Lógica para consumir la API
    └── pokemon_package.dart # Punto de entrada del paquete
```

## 5. 🔥 Dependencias utilizadas

Este paquete utiliza las siguientes bibliotecas:

| Paquete      | Propósito                                                |
|--------------|----------------------------------------------------------|
| http         | Realizar solicitudes HTTP a la PokéAPI                   |
| equatable    | Comparar modelos de datos de manera eficiente            |
| flutter_bloc | (Opcional) Manejo del estado si se usa dentro de un BLoC |

Para instalar todas las dependencias correctamente, simplemente ejecuta:

```bash
flutter pub get
```

## 6. 📜 Licencia
Este proyecto está bajo la MIT License - Eres libre de usarlo, modificarlo y compartirlo.