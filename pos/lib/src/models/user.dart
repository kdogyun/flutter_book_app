class User {
  String _phone;
  String _b_name, _b_item, _b_area;
  bool _upgrade;
  DateTime _created_at, _updated_at;
  List<_Menu> _menus = [];
  List<_Category> _categories = [];

  User(this._phone, this._b_name, this._b_item, this._b_area, this._upgrade,
      this._created_at, this._updated_at, this._menus, this._categories);

  List<_Menu> get menus => _menus;
  List<_Category> get categories => _categories;
  String get phone => _phone;
  String get b_name => _b_name;
  String get b_item => _b_item;
  String get b_area => _b_area;
  bool get upgrade => _upgrade;
  DateTime get created_at => _created_at;
  DateTime get updated_at => _updated_at;
}

class _Menu {
  String _name, _category;
  int _price;

  _Menu(this._name, this._category, this._price);

  String get name => _name;
  String get category => _category;
  int get price => _price;
}

class _Category {
  String _name;
  int _order;

  _Category(this._name, this._order);

  String get name => _name;
  int get order => _order;
}
