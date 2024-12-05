

import 'package:equatable/equatable.dart';

class Character extends Equatable{
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  Character({required this.id, required this.name,required this.status,required this.species,required this.gender,required this.image});

  factory Character.fromMap(Map<String, dynamic> json) => new Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image']
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image
    };
  }

  @override
  List<Object?> get props => [id, name, status, species, gender, image];
}