
import 'package:flutter/material.dart';
import 'package:finance_tracker/home_screen.dart';
import 'package:finance_tracker/theme/theme.dart';
import 'package:finance_tracker/helper/object_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  final ObjectBox objectBox;

  const MyApp({super.key, required this.objectBox});
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode currentTheme = ThemeMode.light;
  

  @override
  void initState() {
    super.initState();
    _loadSavedTheme();
    
  }

  void _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');
    setState(() {
      currentTheme = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      currentTheme = themeMode;
    });
    _saveTheme(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(

      title: 'Finance Tracker',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: currentTheme,
      home: MyHomePage(
        title: 'Finances',
        objectBox: widget.objectBox,
        onThemeChange: _changeTheme,
      ),
    );
  }
}
