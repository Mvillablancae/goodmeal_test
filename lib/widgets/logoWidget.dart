import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
    @required this.sizingInfo,
  }) : super(key: key);

  final BoxConstraints sizingInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizingInfo.maxHeight * 0.02),
      child: Container(
          height: sizingInfo.maxHeight * 0.07,
          child: Image.asset('assets/img/Logo.png')),
    );
  }
}
