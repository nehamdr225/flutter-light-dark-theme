import 'package:dark_light_theme_provider/providers/themeProv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Theme"),
      ),
      body: Consumer<ThemeProv>(
        builder: (context, model, _) => Column(
          children: <Widget>[
            RadioListTile(
              title: Text("System"),
              groupValue: model.theme,
              value: ThemeMode.system,
              onChanged: (value) {
                Provider.of<ThemeProv>(context, listen: false).setTheme(value);
              },
            ),
            RadioListTile(
              title: Text("Light"),
              groupValue: model.theme,
              value: ThemeMode.light,
              onChanged: (value) {
                Provider.of<ThemeProv>(context, listen: false).setTheme(value);
              },
            ),
            RadioListTile(
              title: Text("Dark"),
              groupValue: model.theme,
              value: ThemeMode.dark,
              onChanged: (value) {
                Provider.of<ThemeProv>(context, listen: false).setTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
