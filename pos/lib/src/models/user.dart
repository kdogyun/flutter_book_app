class User {
  String _phone;
  String _b_name, _b_item, _b_area;
  bool _upgrade;
  DateTime _created_at, _updated_at;
  List<_Menu> _menus = [];
  List<_Category> _categories = [];

  User.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _b_name = parsedJson['phone'];
    _b_name = parsedJson['b_name'];
    _b_item = parsedJson['b_item'];
    _b_area = parsedJson['b_area'];
    _upgrade = parsedJson['upgrade'];
    _created_at = parsedJson['created_at'];
    _updated_at = parsedJson['updated_at'];
    List<_Menu> temp = [];
    for (int i = 0; i < parsedJson['menus'].length; i++) {
      _Menu result = _Menu(parsedJson['menus'][i]);
      temp.add(result);
    }
    _menus = temp;

    List<_Category> temp2 = [];
    for (int i = 0; i < parsedJson['menus'].length; i++) {
      _Category result = _Category(parsedJson['categories'][i]);
      temp2.add(result);
    }
    _categories = temp2;
  }

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

  _Menu(result) {
    _name = result['name'];
    _category = result['category'];
    _price = result['price'];
  }

  String get name => _name;
  String get category => _category;

  int get price => _price;
}

class _Category {
  String _name;
  int _order;

  _Category(result) {
    _name = result['name'];
    _order = result['order'];
  }

  String get name => _name;

  int get order => _order;
}
