class Receipt {
  String _phone, _type;
  DateTime _created_at;
  int _total;
  List<_Content> _contents;

  Receipt(
      this._phone, this._type, this._created_at, this._total, this._contents);

  List<_Content> get contents => _contents;
  String get phone => _phone;
  String get type => _type;
  DateTime get created_at => _created_at;
  int get total => _total;
}

class _Content {
  String _name;
  int _price, _count, _sum;

  _Content(this._name, this._price, this._count, this._sum);

  String get name => _name;
  int get price => _price;
  int get count => _count;
  int get sum => _sum;
}
