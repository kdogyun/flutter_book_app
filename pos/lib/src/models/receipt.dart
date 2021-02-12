import 'package:json_annotation/json_annotation.dart';
part 'receipt.g.dart';

@JsonSerializable()
class Receipt {
  String phone, type;
  DateTime createdAt;
  int total;
  List<Content> contents;

  Receipt(this.phone, this.type, this.createdAt, this.total, this.contents);

  // List<_Content> get contents => _contents;
  // String get phone => _phone;
  // String get type => _type;
  // DateTime get created_at => _created_at;
  // int get total => _total;
  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}

@JsonSerializable()
class Content {
  String name;
  int price, count, sum;

  Content(this.name, this.price, this.count, this.sum);

  // String get name => _name;
  // int get price => _price;
  // int get count => _count;
  // int get sum => _sum;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
