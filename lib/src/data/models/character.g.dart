// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['name'] as String?,
      json['image'] as String?,
      json['status'] as String?,
      json['species'] as String?,
      json['type'] as String?,
      json['gender'] as String?,
      json['origin'] as Map<String, dynamic>?,
      json['location'] as Map<String, dynamic>?,
      json['episode'] as List<dynamic>?,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'episode': instance.episode,
    };
