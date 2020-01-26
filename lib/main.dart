import 'package:dark_light_theme_provider/pages/themePage.dart';
import 'package:dark_light_theme_provider/providers/themeProv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int index = prefs.getInt('theme') ?? 0;

  List<ThemeMode> modes = ThemeMode.values;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProv>(create: (_) => ThemeProv()),
      ],
      child: MyApp(themeMode: modes[index]),
    ),
  );
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;
  const MyApp({
    Key key,
    @required this.themeMode,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProv>(context, listen: false).setTheme(widget.themeMode);
  }

  didChangeDependencies() {
    super.didChangeDependencies();
    final themeMode = Provider.of<ThemeProv>(context).theme ?? widget.themeMode;
    if (themeMode != this.themeMode) {
      this.themeMode = themeMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      // DEFAULT FLUTTER THEMES
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      //CUSTOM LIGHT THEME
      theme: ThemeData(
        // Brigthness of the Theme
        brightness: Brightness.light,
        //YOUR_CUSTOM_COLORS
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo.shade700,
        accentColor: Colors.redAccent,
      ),
      //CUSTOM DARK THEME
      darkTheme: ThemeData(
        // Brigthness of the Theme
        brightness: Brightness.dark,
        //YOUR_CUSTOM_COLORS
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal.shade300,
        accentColor: Colors.deepOrangeAccent,
      ),
      // My ThemeMode from provider/shared preferences
      themeMode: themeMode,
      home: ThemePage(),
    );
  }
}
