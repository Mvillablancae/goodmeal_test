import 'package:flutter/material.dart';
import 'package:goodmeal_test/core/utils/colors.dart' as colors;

class LocalWeatherCard extends StatelessWidget {
  const LocalWeatherCard({
    Key key,
    this.sizingInfo,
  }) : super(key: key);

  final BoxConstraints sizingInfo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, localSizing) {
      return Container(
        width: sizingInfo.maxWidth * 0.8,
        height: sizingInfo.maxHeight * 0.3,
        decoration: BoxDecoration(
            color: colors.weatherCardColor,
            borderRadius: BorderRadius.circular(sizingInfo.maxWidth * 0.02),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: colors.shadowColor),
            ]),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: localSizing.maxWidth * 0.05),
                child: Text(
                  "Comuna",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: sizingInfo.maxHeight * 0.01,
                    horizontal: localSizing.maxWidth * 0.05),
                child: Text(
                  "País",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: localSizing.maxWidth * 0.3,
                    height: localSizing.maxWidth * 0.3,
                    //color: Colors.pink,
                    child: Image.asset("assets/img/sol.png"),
                  ),
                  Container(
                    height: localSizing.maxWidth * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Soleado",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mín / Máx",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "16 ºC/ 31 ºC",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
