class Globals {
  var baseUrl = '';
  var token = '';

  Globals._internal();
  
  static final Globals _singleton = Globals._internal();
  factory Globals() {
    return _singleton;
  }
}
