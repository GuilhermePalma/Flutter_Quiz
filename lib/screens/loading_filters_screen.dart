import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/screens/error_screen.dart';

import '../components/loading_widget.dart';
import '../exceptions/http_exceptions.dart';
import '../utils/requests_url.dart';
import 'filters_screen.dart';

class LoadingFiltersScreen extends StatelessWidget {
  const LoadingFiltersScreen({Key? key}) : super(key: key);

  static const List<String> _difficulties = ["easy", "medium", "hard"];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_getCategories(), _getTags()]),
      builder: (ctx, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: LoadingWidget()));
        } else if (snapshot.error != null || snapshot.data == null) {
          return const ErrorScreen();
        } else {
          return FiltersScreen(
            categories: snapshot.data![0],
            tags: snapshot.data![1],
            difficulties: _difficulties,
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> _getCategories() async {
    try {
      final responseAPI = await http.get(Uri.parse(RequestsUrl.urlCategories));

      if (responseAPI.statusCode != 200) {
        throw (HttpExceptions(
          message: "Houve um Erro ao Obter as Categorias",
          statusCode: responseAPI.statusCode,
          bodyError: responseAPI.body,
        ));
      } else {
        return jsonDecode(responseAPI.body);
      }
    } catch (ex) {
      throw (HttpExceptions(
          message: "Houve uma Exceção ao Obter as Categorias",
          statusCode: 500,
          bodyError: ex.toString()));
    }
  }

  Future<List<dynamic>> _getTags() async {
    try {
      final responseAPI = await http.get(Uri.parse(RequestsUrl.urlTags));

      if (responseAPI.statusCode != 200) {
        throw (HttpExceptions(
          message: "Houve um Erro ao Obter as Tags",
          statusCode: responseAPI.statusCode,
          bodyError: responseAPI.body,
        ));
      } else {
        return jsonDecode(responseAPI.body);
      }
    } catch (ex) {
      throw (HttpExceptions(
          message: "Houve uma Exceção ao Obter as Tags",
          statusCode: 500,
          bodyError: ex.toString()));
    }
  }
}
