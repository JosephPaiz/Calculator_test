import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator_test/models/calculator_model.dart';
import 'package:calculator_test/views/calculator_view.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CalculatorView(),
      ),
    );
  }
}
