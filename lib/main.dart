import 'package:casestudy/core/sharedpreferences/sharedprefence.dart';
import 'package:casestudy/pages/homepage.dart';
import 'package:casestudy/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

//sharedPreferences kullanarak  true/false yardımıyla kontrol yapıyorum
  Future<bool> hasEnteredBefore() async {
    final enteredBefore = await SharedPref().getenteredBefore();
    return enteredBefore ?? false;
  }
  //sharedPreferences kullanarak token ile  kontrol yapıyorum
  Future<bool> hasEnteredBefore2() async {
     bool enteredBefore= false;
    final token = await SharedPref().getToken();
    print(token);
    if(token=="QpwL5tke4Pnpja7X4"){

      enteredBefore =  true  ;
    }

     return enteredBefore;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasEnteredBefore2(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return CircularProgressIndicator();
        } else if (snapshot.hasError) {

          return Text('Error: ${snapshot.error}');
        } else {
          final enteredBefore = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: enteredBefore ? HomePage() : LoginPage(),

          );
        }
      },
    );
  }
}


