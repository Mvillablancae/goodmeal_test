import 'package:flutter/material.dart';
import 'package:goodmeal_test/widgets/wewBaseWidget.dart';

class SelectedCityScreen extends StatelessWidget {
  static const String routeName = '/city';
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizingInfo) {
      return WewBaseWidget(child: 
        Container()
      );
    });
  }
}
