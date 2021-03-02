import 'package:firstapp/views/test_view/test_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firstapp/views/home_view/home_view.dart';
import 'package:provider/provider.dart';

import 'home_view/home_view_model.dart';

const String initialRoute = "login";

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ChangeNotifierProvider(create: (_) => HomeViewModel(), child: HomeView()));
      case 'test':
        return MaterialPageRoute(builder: (_) => TestView());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: FlatButton(
                        color: Colors.blue,
                        child: Text(
                          'No route defined for ${settings.name}',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.pushReplacementNamed(context, '/');
                        }),
                  ),
                ));
    }
  }
}
