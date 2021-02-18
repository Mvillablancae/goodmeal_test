import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodmeal_test/components/search/bloc/search_bloc.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:goodmeal_test/models/forecast.dart';
import 'package:goodmeal_test/widgets/loadingScreen.dart';
import 'package:goodmeal_test/widgets/logoWidget.dart';
import 'package:goodmeal_test/widgets/wewBaseWidget.dart';
import 'package:goodmeal_test/utils/colors.dart' as colors;

class SelectedCity extends StatelessWidget {
  static const String routeName = '/city';
  SearchBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<SearchBloc>(context);

    return LayoutBuilder(builder: (context, sizingInfo) {
      return BlocConsumer(
          cubit: _bloc,
          listener: (context, state) {
            if (state is SearchStarted) Navigator.pop(context);
          },
          builder: (context, state) {
            if (state is SearchCompleted) {
              return WewBaseWidget(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => _bloc.add(Search(
                                  searchString: _bloc.getlastSearchedWord))),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizingInfo.maxWidth * 0.05,
                                vertical: sizingInfo.maxHeight * 0.02),
                            child: Text(
                              "${state.selectedCity.name}, ${CitiesRepository.instance.countries[state.selectedCity.country]['name']}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          height: sizingInfo.maxHeight * 0.75,
                          width: sizingInfo.maxWidth * 0.8,
                          decoration: BoxDecoration(
                            color: colors.weatherCardColor,
                            borderRadius: BorderRadius.circular(
                                sizingInfo.maxHeight * 0.02),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DayDetailsRow(
                                day: "Hoy",
                                sizingInfo: sizingInfo,
                                forecast: state.forecast.threeDayForecast[0],
                              ),
                              DayDetailsRow(
                                day: "Mañana",
                                sizingInfo: sizingInfo,
                                forecast: state.forecast.threeDayForecast[1],
                              ),
                              DayDetailsRow(
                                day: "Pasado mañana",
                                sizingInfo: sizingInfo,
                                forecast: state.forecast.threeDayForecast[2],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  LogoWidget(
                    sizingInfo: sizingInfo,
                  ),
                ],
              ));
            } else
              return LoadingScreen(
                sizingInfo: sizingInfo,
              );
          });
    });
  }
}

class DayDetailsRow extends StatelessWidget {
  const DayDetailsRow({Key key, this.sizingInfo, this.forecast, this.day})
      : super(key: key);

  final BoxConstraints sizingInfo;
  final String day;
  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizingInfo.maxHeight * 0.22,
      width: sizingInfo.maxWidth * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: sizingInfo.maxWidth * 0.4,
                child: Text(
                  day,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              Container(
                height: sizingInfo.maxHeight * 0.13,
                width: sizingInfo.maxHeight * 0.13,
                child: Image.asset('assets/img/sol.png'),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${forecast.weather}",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                "Mín/Máx",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                "${forecast.min}/${forecast.max} ºC",
                style: TextStyle(color: Colors.white, fontSize: 22),
              )
            ],
          ),
        ],
      ),
    );
  }
}
