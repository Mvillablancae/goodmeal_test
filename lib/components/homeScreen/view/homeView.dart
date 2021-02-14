import 'package:flutter/material.dart';
import 'package:goodmeal_test/components/homeScreen/view/localWeatherCard.dart';
import 'package:goodmeal_test/core/citiesRepository.dart';
import 'package:goodmeal_test/widgets/logoWidget.dart';
import 'package:goodmeal_test/widgets/wewBaseWidget.dart';

import 'package:goodmeal_test/widgets/wewTextFormField.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizingInfo) {
      return WewBaseWidget(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: sizingInfo.maxHeight * 0.05,
                    left: sizingInfo.maxWidth * 0.1),
                child: Text(
                  "Tu ubicación actual",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                ),
              ),
              _buildCard(sizingInfo),
              _buildCityForm(sizingInfo),
            ],
          ),
          LogoWidget(
            sizingInfo: sizingInfo,
          ),
        ],
      );
    });
  }

  Padding _buildCard(BoxConstraints sizingInfo) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: sizingInfo.maxHeight * 0.03,
      ),
      child: Center(
        child: LocalWeatherCard(
          sizingInfo: sizingInfo,
        ),
      ),
    );
  }

  Center _buildCityForm(BoxConstraints sizingInfo) {
    return Center(
      child: Container(
        width: sizingInfo.maxWidth * 0.8,
        height: sizingInfo.maxHeight * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: sizingInfo.maxWidth * 0.05,
                  bottom: sizingInfo.maxHeight * 0.01),
              child: Text(
                "Conoce otros pronósticos",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            WewTextFormField(
              hintText: "Busca cualquier ciudad del mundo",
              sizingInfo: sizingInfo,
              onTap: () async {
                print("Se Apreta Textfield");
                await CitiesRepository.instance.loadData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
