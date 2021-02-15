

import 'package:flutter/material.dart';
import 'package:goodmeal_test/utils/colors.dart' as colors;

class WewBaseWidget extends StatelessWidget {
  const WewBaseWidget({
    Key key,
    @required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizingInfo) {
      return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: Container(
          height: sizingInfo.maxHeight,
          width: sizingInfo.maxWidth,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height:
                    sizingInfo.maxHeight - MediaQuery.of(context).padding.top,
                width: sizingInfo.maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}