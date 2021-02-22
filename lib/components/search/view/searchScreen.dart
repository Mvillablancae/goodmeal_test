import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/view/homeScreen.dart';
import 'package:goodmeal_test/components/search/bloc/search_bloc.dart';
import 'package:goodmeal_test/components/search/view/selectedCity.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:goodmeal_test/core/widgets/wewBaseWidget.dart';
import 'package:goodmeal_test/core/widgets/wewTextFormField.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/Search";
  SearchBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<SearchBloc>(context);
    print("Bloc is searching: ${_bloc.isSearching}");
    FocusNode focusNode;
    return LayoutBuilder(builder: (context, sizingInfo) {
      return WewBaseWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AutocompleteTextField(
                  focusNode: focusNode, bloc: _bloc, sizingInfo: sizingInfo),
              SearchResults(
                  bloc: _bloc, focusNode: focusNode, sizingInfo: sizingInfo),
            ],
          ),
        ),
      );
    });
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults(
      {Key key,
      @required SearchBloc bloc,
      @required this.focusNode,
      @required this.sizingInfo})
      : _bloc = bloc,
        super(key: key);

  final SearchBloc _bloc;
  final FocusNode focusNode;
  final BoxConstraints sizingInfo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      cubit: _bloc,
      listener: (context, state) {
        if (state is SearchIdle) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else if (state is SearchCompleted) {
          Navigator.of(context).pushNamed(SelectedCity.routeName);
        } else if (state is SearchFailed) {
          _showFailedDialog(context, state);
        }
      },
      builder: (context, state) {
        if (state is SearchStarted) {
          if (state.filteredCities.length != 0)
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.filteredCities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizingInfo.maxWidth * 0.1),
                  child: Column(
                    children: [
                      ListTile(
                        trailing: Padding(
                          padding: EdgeInsets.only(
                              right: sizingInfo.maxWidth * 0.05),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          _bloc.add(
                              SelectCity(city: state.filteredCities[index]));
                        },
                        title: Text(
                          "${state.filteredCities[index].name}, ${CitiesRepository.instance.countries[state.filteredCities[index].country]['name']}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                    ],
                  ),
                );
              },
            );
          else {
            return Center(
              child: Text(
                "No se encontraron ciudades",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        } else if (state is OpenedSearch) {
          return Container();
        } else
          return Container(
            height: sizingInfo.maxHeight * 0.2,
            width: sizingInfo.maxWidth,
            child: Center(
              child: Container(
                height: sizingInfo.maxWidth * 0.1,
                width: sizingInfo.maxWidth * 0.1,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          );
      },
    );
  }

  Future _showFailedDialog(BuildContext context, SearchFailed state) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Ha ocurrido algo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text("${state.errorMsje['error']}"),
              ),
            ],
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  CitiesRepository.instance.textController.text = '';
                  _bloc.changeCurrentWord = '';
                  focusNode.unfocus();
                  _bloc.add(Search(
                      searchString: CitiesRepository.instance.searchingText));
                  Navigator.of(context).pop();
                },
                child: Text("Aceptar"))
          ],
        ));
  }
}

class AutocompleteTextField extends StatelessWidget {
  const AutocompleteTextField(
      {Key key,
      @required this.focusNode,
      @required SearchBloc bloc,
      @required this.sizingInfo})
      : _bloc = bloc,
        super(key: key);

  final FocusNode focusNode;
  final SearchBloc _bloc;
  final BoxConstraints sizingInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizingInfo.maxHeight * 0.02),
      child: Container(
        width: sizingInfo.maxWidth * 0.8,
        child: Hero(
          tag: 'SearchField',
          child: WewTextFormField(
            hintText: "Busca cualquier ciudad del mundo",
            focusNode: focusNode,
            autofocus: true,
            suffix: InkWell(
              onTap: () {
                CitiesRepository.instance.textController.text = '';
                _bloc.changeCurrentWord = '';
                _bloc.add(Search(
                    searchString: CitiesRepository.instance.searchingText));
              },
              child: Icon(Icons.close),
            ),
            sizingInfo: sizingInfo,
            onChange: (text) {
              _bloc.changeCurrentWord = text;
              if (!_bloc.isSearching) {
                _bloc.add(Search(
                    searchString: CitiesRepository.instance.searchingText));
              }
            },
          ),
        ),
      ),
    );
  }
}
