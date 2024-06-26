import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
 // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
   //   .then((fn) {
    runApp(const MyApp());
 // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpenseProvider>(
            create: (_) => ExpenseProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //datePickerTheme:
          // const DatePickerThemeData(backgroundColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
