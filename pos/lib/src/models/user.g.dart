// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['phone'] as String,
    json['bName'] as String,
    json['bItem'] as String,
    json['bArea'] as String,
    json['upgrade'] as bool,
    User._fromJson(json['createdAt'] as int),
    (json['menus'] as List)
        ?.map(
            (e) => e == null ? null : Menu.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phone': instance.phone,
      'bName': instance.bName,
      'bItem': instance.bItem,
      'bArea': instance.bArea,
      'upgrade': instance.upgrade,
      'createdAt': User._toJson(instance.createdAt),
      'menus': instance.menus?.map((e) => e?.toJson())?.toList(),
      'categories': instance.categories?.map((e) => e?.toJson())?.toList(),
    };

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    json['name'] as String,
    json['category'] as String,
    json['price'] as int,
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'price': instance.price,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['name'] as String,
    json['order'] as int,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
      'order': instance.order,
    };
