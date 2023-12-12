import 'package:flutter/material.dart';
import 'sql_helper.dart'; // Import your SQL Helper
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase(); // Initializing the SQLite database
  runApp(const MyApp());
}

Future<void> initDatabase() async {
  await SQLHelper.database(); // Initialize your SQLite database
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
