import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/model/entities/quiz_entity.dart';
import 'package:quiz/screens/quiz_screen.dart';
import 'package:quiz/utils/requests_url.dart';

import '../components/loading_widget.dart';
import '../exceptions/http_exceptions.dart';
import 'error_screen.dart';

class QuizLoadingScreen extends StatelessWidget {
  const QuizLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _stringRequest = ModalRoute.of(context)?.settings.arguments ??
        RequestsUrl.urlQuestionsBase;

    return FutureBuilder(
      future: _getQuestions(_stringRequest.toString()),
      builder: (ctx, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: LoadingWidget()));
        } else if (snapshot.error != null || snapshot.data == null) {
          return const ErrorScreen();
        } else {
          return QuizScreen(quiz: snapshot.data);
        }
      },
    );
  }

  Future<List<QuizEntity>> _getQuestions(String stringRequest) async {
    try {
      final responseAPI = await http.get(Uri.parse(stringRequest));

      if (responseAPI.statusCode != 200) {
        throw (HttpExceptions(
          message: "Houve um Erro ao Obter as Questões",
          statusCode: responseAPI.statusCode,
          bodyError: responseAPI.body,
        ));
      } else {
        return QuizEntity.fromJsonArray(responseAPI.body);
      }
    } catch (ex) {
      throw (HttpExceptions(
          message: "Houve uma Exceção ao Obter as Questões",
          statusCode: 500,
          bodyError: ex.toString()));
    }
  }
}
