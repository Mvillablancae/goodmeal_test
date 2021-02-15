import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/bloc/home_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/view/localWeatherCard.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:goodmeal_test/widgets/logoWidget.dart';
import 'package:goodmeal_test/widgets/wewBaseWidget.dart';

import 'package:goodmeal_test/widgets/wewTextFormField.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizingInfo) {
      return BlocBuilder(
          cubit: BlocProvider.of<HomeBloc>(context),
          builder: (context, state) {
            if (state is HomeInitialized)
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
                      HomeCard(sizingInfo: sizingInfo),
                      CityForm(sizingInfo: sizingInfo),
                    ],
                  ),
                  LogoWidget(
                    sizingInfo: sizingInfo,
                  ),
                ],
              );
            else
              return WewBaseWidget(children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(sizingInfo.maxHeight * 0.04),
                          child: Container(
                              height: sizingInfo.maxHeight * 0.08,
                              child: Image.asset('assets/img/Logo.png')),
                        ),
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ]);
          });
    });
  }
}

class CityForm extends StatelessWidget {
  const CityForm({
    Key key,
    this.sizingInfo,
  }) : super(key: key);

  final BoxConstraints sizingInfo;

  @override
  Widget build(BuildContext context) {
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

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
    this.sizingInfo,
  }) : super(key: key);

  final BoxConstraints sizingInfo;

  @override
  Widget build(BuildContext context) {
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
}
