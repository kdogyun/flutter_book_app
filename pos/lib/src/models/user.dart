import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String phone;
  String bName, bItem, bArea;
  bool upgrade;
  DateTime createdAt, updatedAt;
  List<Menu> menus = [];
  List<Category> categories = [];

  User(this.phone, this.bName, this.bItem, this.bArea, this.upgrade,
      this.createdAt, this.updatedAt, this.menus, this.categories);

  // List<_Menu> get menus => _menus;
  // List<_Category> get categories => _categories;
  // String get phone => _phone;
  // String get b_name => _b_name;
  // String get b_item => _b_item;
  // String get b_area => _b_area;
  // bool get upgrade => _upgrade;
  // DateTime get created_at => _created_at;
  // DateTime get updated_at => _updated_at;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Menu {
  String name, category;
  int price;

  Menu(this.name, this.category, this.price);

  // String get name => _name;
  // String get category => _category;
  // int get price => _price;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable()
class Category {
  String name;
  int order;

  Category(this.name, this.order);

  // String get name => _name;
  // int get order => _order;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
