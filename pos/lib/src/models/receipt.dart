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

  // https://doocong.com/flutter/dart-study2
  Content.three(String name, int price, int count) {
    this.name = name;
    this.price = price;
    this.count = count;
    this.sum = price * count;
  }

  // String get name => _name;
  // int get price => _price;
  // int get count => _count;
  // int get sum => _sum;

  void up() {
    this.count++;
    this.sum = this.count * this.price;
  }

  bool down() {
    this.count--;
    this.sum = this.count * this.price;

    if (this.count < 1)
      return false;
    else
      return true;
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
