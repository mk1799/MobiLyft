import 'package:flutter/material.dart';
import 'package:mobilyft/First_Page/firstpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'First_Page/firstpage.dart';
import 'choice_page/selection.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String spe;
  spe=prefs.getString('email');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: spe != null ? section_page(email: spe) : FirstPagee()
      )
    ); 
  }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Moilyft",
        home: SafeArea(
                  child: Scaffold(
                body: FirstPagee(),
                ),
            ),
          );
        }
      }
