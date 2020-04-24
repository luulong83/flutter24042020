import 'dart:async';
//https://morioh.com/p/38d963805a67
//https://fireship.io/lessons/advanced-flutter-firebase/
//https://www.developerlibs.com/2018/11/flutter-firebase-realtime-database-crud.html

class FirebaseService {
  String nameTableDevices = 'DEVICES';

  static final FirebaseService _instance = new FirebaseService.internal();
  FirebaseService.internal();

  factory FirebaseService() {
    return _instance;
  }

  void initState() {
  }
  /* Lắng nghe sự kiện firebase thay đổi */
  ///https://www.youtube.com/watch?v=Bper2K92bd8&feature=youtu.be
}
