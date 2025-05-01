
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/repository.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WisataRepository(),
      child: MaterialApp(
        title: 'Wisata App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey.shade100,
        ),
        home: const HomePage(),
      ),
    );
  }
}
