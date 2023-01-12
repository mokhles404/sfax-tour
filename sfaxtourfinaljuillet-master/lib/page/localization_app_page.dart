

import 'package:flutter/material.dart';
import 'package:untitled1/Screens/LanguagePicker.dart';


class LocalizationAppPage extends StatefulWidget {
  @override
  _LocalizationAppPageState createState() => _LocalizationAppPageState();
}

class _LocalizationAppPageState extends State<LocalizationAppPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(

      centerTitle: true,
      actions: [
        LanguagePickerWidget(),
        const SizedBox(width: 12),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LanguageWidget(),
          const SizedBox(height: 32),

          const SizedBox(height: 8),

        ],
      ),
    ),
  );
}