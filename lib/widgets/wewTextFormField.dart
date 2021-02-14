import 'package:flutter/material.dart';

class WewTextFormField extends StatelessWidget {
  const WewTextFormField({
    Key key,
    @required this.hintText,
    @required this.sizingInfo,
    this.onTap,
  }) : super(key: key);

  final String hintText;
  final BoxConstraints sizingInfo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0XFFAAAAAA), fontSize: 18.0),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: sizingInfo.maxWidth * 0.05),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(sizingInfo.maxHeight * 0.1)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(sizingInfo.maxHeight * 0.1)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(sizingInfo.maxHeight * 0.1)),
      ),
    );
  }
}
