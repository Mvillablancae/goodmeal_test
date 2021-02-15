import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/view/homeScreen.dart';
import 'package:goodmeal_test/components/search/bloc/search_bloc.dart';
import 'package:goodmeal_test/components/search/view/selectedCity.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:goodmeal_test/widgets/wewBaseWidget.dart';
import 'package:goodmeal_test/widgets/wewTextFormField.dart';
import 'package:goodmeal_test/utils/colors.dart' as colors;

class SearchScreen extends StatelessWidget {
  static const String routeName = '/seachScreen';
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizingInfo) {
      return WewBaseWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: sizingInfo.maxHeight * 0.02),
                child: Container(
                  width: sizingInfo.maxWidth * 0.8,
                  child: Hero(
                    tag: 'SearchField',
                    child: WewTextFormField(
                      hintText: "Busca cualquier ciudad del mundo",
                      sizingInfo: sizingInfo,
                      suffix: BlocBuilder(
                        cubit: BlocProvider.of<SearchBloc>(context),
                        builder: (context, state) => state is SearchLoading
                            ? Container(
                                padding: EdgeInsets.only(
                                    right: sizingInfo.maxWidth * 0.08),
                                height: sizingInfo.maxHeight * 0.02,
                                width: sizingInfo.maxHeight * 0.02,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      colors.backgroundColor),
                                ),
                              )
                            : Container(
                                height: 0,
                                width: 0,
                              ),
                      ),
                      onChange: (text) async {
                        BlocProvider.of<SearchBloc>(context).add(Search(
                            searchString:
                                CitiesRepository.instance.searchingText));
                      },
                    ),
                  ),
                ),
              ),
              BlocConsumer(
                cubit: BlocProvider.of<SearchBloc>(context),
                listener: (context, state) {
                  if (state is SearchIdle)
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  else if (state is SearchCompleted)
                    Navigator.of(context)
                        .pushNamed(SelectedCityScreen.routeName);
                },
                builder: (context, state) {
                  if (state is SearchStarted) {
                    if (state.filteredCities.length != 0)
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.filteredCities.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              onTap: () {
                                BlocProvider.of<SearchBloc>(context).add(
                                    SelectCity(
                                        city: state.filteredCities[index]));
                              },
                              title: Text(
                                  "${state.filteredCities[index].name}, ${CitiesRepository.instance.countries[state.filteredCities[index].country]['name']}"));
                        },
                      );
                    else {
                      return Center(
                        child: Text("No se encontraron ciudades"),
                      );
                    }
                  } else
                    return Container(
                      height: 0,
                      width: 0,
                    );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
