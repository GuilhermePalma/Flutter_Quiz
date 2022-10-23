import 'package:flutter/material.dart';
import 'package:quiz/screens/error_screen.dart';
import 'package:quiz/screens/home_screen.dart';
import 'package:quiz/screens/loading_filters_screen.dart';
import 'package:quiz/screens/quiz_loading_screen.dart';
import 'package:quiz/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.homeRoute: (ctx) => const HomeScreen(),
        AppRoutes.randomQuestions: (ctx) => const QuizLoadingScreen(),
        AppRoutes.tagsAndCategories: (ctx) => const LoadingFiltersScreen(),
      },
      initialRoute: AppRoutes.homeRoute,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (_) => const ErrorScreen()),
    );
  }
}
