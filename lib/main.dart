import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_path_provider/setup.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Note App",
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
        home: const HomePage()
    );
  }
}
