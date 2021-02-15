import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodmeal_test/components/search/bloc/search_bloc.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:goodmeal_test/widgets/wewBaseWidget.dart';
import 'package:goodmeal_test/widgets/wewTextFormField.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/seachScreen';
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, sizingInfo) {
      return WewBaseWidget(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: sizingInfo.maxHeight * 0.02),
          child: Container(
            width: sizingInfo.maxWidth * 0.8,
            child: Hero(
              tag: 'SearchField',
              child: WewTextFormField(
                hintText: "Busca cualquier ciudad del mundo",
                sizingInfo: sizingInfo,
                onChange: (text) async {
                  BlocProvider.of<SearchBloc>(context).add(Search());
                },
              ),
            ),
          ),
        ),
        BlocBuilder(
          cubit: BlocProvider.of<SearchBloc>(context),
          builder: (context, state) {
            if (state is SearchStarted) {
              if (state.filteredCities.length != 0)
                return ListView.builder(
                  itemCount: state.filteredCities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          BlocProvider.of<SearchBloc>(context).add(
                              SelectCity(city: state.filteredCities[index]));
                        },
                        title: Text(
                            "${state.filteredCities[index].name}, ${CitiesRepository.instance.countries[state.filteredCities[index].country]}"));
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
        )
      ]);
    });
  }
}
