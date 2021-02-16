import 'package:flutter/material.dart';
import 'package:goodmeal_test/utils/colors.dart' as colors;

class WewBaseWidget extends StatelessWidget {
  const WewBaseWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizingInfo) {
      return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: Container(
          height: sizingInfo.maxHeight,
          width: sizingInfo.maxWidth,
          child: SafeArea(child: child),
        ),
      );
    });
  }
}
