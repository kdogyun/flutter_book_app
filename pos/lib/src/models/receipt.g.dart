// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) {
  return Receipt(
    json['phone'] as String,
    json['type'] as String,
    Receipt._fromJson(json['createdAt'] as int),
    json['total'] as int,
    (json['contents'] as List)
        ?.map((e) =>
            e == null ? null : Content.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'phone': instance.phone,
      'type': instance.type,
      'createdAt': Receipt._toJson(instance.createdAt),
      'total': instance.total,
      'contents': instance.contents?.map((e) => e?.toJson())?.toList(),
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['name'] as String,
    json['price'] as int,
    json['count'] as int,
    json['sum'] as int,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'count': instance.count,
      'sum': instance.sum,
    };
