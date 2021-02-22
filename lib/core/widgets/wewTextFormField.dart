import 'package:flutter/material.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';

class WewTextFormField extends StatelessWidget {
  WewTextFormField(
      {Key key,
      @required this.hintText,
      @required this.sizingInfo,
      this.onTap,
      this.onChange,
      this.suffix,
      this.focusNode,
      this.autofocus})
      : super(key: key);

  final String hintText;
  final BoxConstraints sizingInfo;
  final VoidCallback onTap;
  final Function(String) onChange;
  final TextEditingController _controller =
      CitiesRepository.instance.textController;
  final FocusNode focusNode;
  final Widget suffix;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              textAlignVertical: TextAlignVertical.center,
              onTap: onTap,
              onChanged: onChange,
              controller: _controller,
              autofocus: autofocus == null ? false : true,
              decoration: InputDecoration(
                suffixIcon: suffix,
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(color: Color(0XFFAAAAAA), fontSize: 18.0),
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.only(top: 10, left: sizingInfo.maxWidth * 0.05),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:
                        BorderRadius.circular(sizingInfo.maxHeight * 0.1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:
                        BorderRadius.circular(sizingInfo.maxHeight * 0.1)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:
                        BorderRadius.circular(sizingInfo.maxHeight * 0.1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
