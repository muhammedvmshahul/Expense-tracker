import 'package:expense_tracker_app/pages/homeScreen/home_Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/expanse_data.dart';



 void main()async{
   await Hive.initFlutter();
   await Hive.openBox('expense_database');
    runApp(const MyApp());

 }



 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   @override
   Widget build(BuildContext context) {
     return ChangeNotifierProvider(
       create: (context) => ExpanseData(),
       builder: (context,child) {
         return const MaterialApp(
           debugShowCheckedModeBanner: false,
             home: HomePage(),
         );
       }
     );
   }
 }
