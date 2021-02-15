


import 'package:flutter/material.dart';
import 'package:goodmeal_test/widgets/wewBaseWidget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
    this.sizingInfo
  }) : super(key: key);

  final BoxConstraints sizingInfo;

  @override
  Widget build(BuildContext context) {
    return WewBaseWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(sizingInfo.maxHeight * 0.04),
              child: Container(
                  height: sizingInfo.maxHeight * 0.12,
                  child: Image.asset('assets/img/Logo.png')),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}