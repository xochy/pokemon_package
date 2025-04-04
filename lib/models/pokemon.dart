import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final String name;
  final String? url;
  final int? id;
  final int? weight;
  final int? height;
  final String? imageUrl;

  const Pokemon({
    required this.name,
    this.url,
    this.id,
    this.weight,
    this.height,
    this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String,
      url: json['url'] as String?,
      id: json['id'] as int?,
      weight: json['weight'] as int?,
      height: json['height'] as int?,
      imageUrl: json['sprites']?['front_default'] as String?,
    );
  }

  @override
  List<Object?> get props => [name, url, id, weight, height, imageUrl];
}
