class Receipt {
  String _phone, _type;
  DateTime _created_at;
  int _total;
  List<_Content> _contents = [];

  Receipt.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _phone = parsedJson['phone'];
    _type = parsedJson['type'];
    _created_at = parsedJson['created_at'];
    _total = parsedJson['total'];

    List<_Content> temp = [];
    for (int i = 0; i < parsedJson['contents'].length; i++) {
      _Content result = _Content(parsedJson['contents'][i]);
      temp.add(result);
    }
    _contents = temp;
  }

  List<_Content> get contents => _contents;

  String get phone => _phone;
  String get type => _type;

  DateTime get created_at => _created_at;

  int get total => _total;
}

class _Content {
  String _name;
  int _price, _count, _sum;

  _Content(result) {
    _name = result['name'];
    _count = result['count'];
    _price = result['price'];
    _sum = result['sum'];
  }

  String get name => _name;

  int get price => _price;
  int get count => _count;
  int get sum => _sum;
}
