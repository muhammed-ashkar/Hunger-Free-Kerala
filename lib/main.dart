import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hunger_free_kerala/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('HungerBox');
  runApp(const HungerFreeKerala());
}
class HungerFreeKerala extends StatelessWidget {
  const HungerFreeKerala({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hunger Free Kerala",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}