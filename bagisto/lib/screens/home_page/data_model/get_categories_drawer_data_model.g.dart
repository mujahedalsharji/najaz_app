// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories_drawer_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetDrawerCategoriesDataAdapter
    extends TypeAdapter<GetDrawerCategoriesData> {
  @override
  final int typeId = 9;

  @override
  GetDrawerCategoriesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetDrawerCategoriesData(
      data: (fields[0] as List?)?.cast<HomeCategories>(),
    );
  }

  @override
  void write(BinaryWriter writer, GetDrawerCategoriesData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetDrawerCategoriesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HomeCategoriesAdapter extends TypeAdapter<HomeCategories> {
  @override
  final int typeId = 10;

  @override
  HomeCategories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeCategories(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      slug: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeCategories obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.slug);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeCategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDrawerCategoriesData _$GetDrawerCategoriesDataFromJson(
        Map<String, dynamic> json) =>
    GetDrawerCategoriesData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HomeCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as String?,
      responseStatus: json['responseStatus'] as bool?,
    );

Map<String, dynamic> _$GetDrawerCategoriesDataToJson(
        GetDrawerCategoriesData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseStatus': instance.responseStatus,
      'data': instance.data,
    };

HomeCategories _$HomeCategoriesFromJson(Map<String, dynamic> json) =>
    HomeCategories(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      logoUrl: json['logoUrl'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Children.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeCategoriesToJson(HomeCategories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'slug': instance.slug,
      'bannerUrl': instance.bannerUrl,
      'logoUrl': instance.logoUrl,
      'children': instance.children,
    };

Children _$ChildrenFromJson(Map<String, dynamic> json) => Children(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$ChildrenToJson(Children instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'bannerUrl': instance.bannerUrl,
      'logoUrl': instance.logoUrl,
    };
