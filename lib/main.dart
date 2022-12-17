import 'package:flutter/material.dart';
import 'package:order_food/cart_print.dart';
import 'package:order_food/home.dart';
import 'package:order_food/providers/provider.dart';
import 'package:order_food/setting.dart';
import 'package:order_food/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CartProvider())],
      child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.amber),
          debugShowCheckedModeBanner: false,
          home: const Splash(),
          initialRoute: "/splas",
          routes: {
            "/splas": (context) => Splash(),
            "/home": (context) => Home(),
            "/cart": (context) => CartPrint(),
            "/setting": (context) => Setting()
          }),
    );
  }
}
