import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterit2/simple_bloc_delegate.dart';
import 'package:provider/provider.dart';

import 'ui/screens/splash/splash.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    MultiProvider(
      providers: [
        //ValueListenableProvider(builder: (context) => ValueNotifier(true)),
        //ChangeNotifierProvider(builder: (context) => CoreNotifier()),
        //ChangeNotifierProvider(builder: (context) => PreferencesNotifier()),
        //Provider<MeetingDocumentBloc>.value(value: MeetingDocumentBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'VNPTIT2',
      initialRoute: '/',
       routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        //'/home': (context) => HomePage(),
        // '/sign-in': (context) => SignInPage(),
        // '/sign-up': (context) => SignUpPage(),
        // '/checkout': (context) => CheckoutPage(),
      },
    );
  }
}

