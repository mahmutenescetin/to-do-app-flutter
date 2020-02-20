class Task{
  int _id;
  String _icon;
  String _name;
  String _description;
  String _dateTime;
  int _done;



  Task(this._icon,this._name,this._description,this._dateTime,this._done);

  Map<String,dynamic>toMap(){
    var map = Map<String,dynamic>();
    map["icon"]= _icon;
    map["name"]= _name;
    map["description"]= _description;
    map["dateTime"]= _dateTime;
    map["done"]= _done;
    if(_id!=null){
      map["id"]= _id;

    }

    return map;
  }
  Task.fromMap(Map<String,dynamic>map){
    this._id= map["id"];
    this._icon= map["icon"];
    this._name= map["name"];
    this._description= map["description"];
    this._dateTime= map["dateTime"];
    this._done= map["done"];
  }

  int get done => _done;

  set done(int value) {
    _done = value;
  }
  int get id => _id;

  set id(int value) {
    _id = value;
  }



  String get icon => _icon;

  set icon(String value) {
    _icon = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get dateTime => _dateTime;

  set dateTime(String value) {
    _dateTime = value;
  }


}