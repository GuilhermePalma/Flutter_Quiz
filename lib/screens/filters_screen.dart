import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/utils/app_routes.dart';
import 'package:quiz/utils/requests_url.dart';

class FiltersScreen extends StatefulWidget {
  final Map<String, dynamic> categories;
  final List<dynamic> tags;
  final List<String> difficulties;

  const FiltersScreen({
    Key? key,
    required this.categories,
    required this.tags,
    required this.difficulties,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Set<String>? _selectedTags;
  Set<String>? _selectedCategory;
  String? _selectedDifficulty;
  double _quantityQuestions = 10;
  String _uriWithFilters = RequestsUrl.urlQuestionsBase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurar Perguntas"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Selecione os Filtros para as Perguntas",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                    children:
                        _getFiltersInputs(widget.categories, widget.tags)),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  var _containsValues = await _checkReturnFilter(context);
                  if (_containsValues) {
                    Navigator.of(context).pushNamed(AppRoutes.randomQuestions,
                        arguments: _uriWithFilters);
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Filtro Invalido"),
                        content: const Text(
                            "Com os Filtros atuais, não há resultados compativeis.\n"
                            "Remova ou Altere os Filtros para Obter as Perguntas"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.golf_course_outlined),
                label: const FittedBox(child: Text("Ir para as Perguntas")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getFiltersInputs(Map<String, dynamic> categories, List<dynamic> tags) {
    return [
      DropdownButtonFormField(
        decoration: const InputDecoration(
          label: Text("Categorias"),
          hintText: "Selecione uma Categoria",
          border: OutlineInputBorder(),
        ),
        items: _createDropDownItems(categories.keys.toList()),
        onChanged: (e) => setState(() {
          if (_selectedCategory == null) {
            _selectedCategory = {e.toString()};
          } else {
            _selectedCategory!.add(e.toString());
          }
        }),
      ),
      const SizedBox(height: 24),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          label: Text("Tags"),
          hintText: "Selecione as Tags",
          border: OutlineInputBorder(),
        ),
        items: _createDropDownItems(tags),
        onChanged: (e) => setState(() {
          if (_selectedTags == null) {
            _selectedTags = {e.toString()};
          } else {
            _selectedTags!.add(e.toString());
          }
        }),
      ),
      const SizedBox(height: 24),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          label: Text("Dificuldade"),
          hintText: "Selecione a Dificuldade",
          border: OutlineInputBorder(),
        ),
        items: _createDropDownItems(widget.difficulties),
        onChanged: (e) => setState(() => _selectedDifficulty = e as String),
      ),
      const SizedBox(height: 24),
      Column(
        children: [
          const Text("Quantidade de Perguntas"),
          Slider(
            value: _quantityQuestions,
            min: 5,
            max: 65,
            divisions: 12,
            label: _quantityQuestions.round().toString(),
            onChanged: (value) => setState(() => _quantityQuestions = value),
          ),
        ],
      ),
    ];
  }

  _createDropDownItems(List<dynamic> list) => list
      .map((item) => DropdownMenuItem(child: Text(item), value: item))
      .toList();

  Future<bool> _checkReturnFilter(BuildContext context) async {
    String uri = "";
    if (_selectedDifficulty != null) {
      uri = RequestsUrl.addDifficultyFilter(uri, _selectedDifficulty!);
    }
    if (_selectedCategory != null) {
      uri = RequestsUrl.addCategoriesFilter(uri, _selectedCategory!.toList());
    }
    if (_selectedTags != null) {
      uri = RequestsUrl.addTagsFilter(uri, _selectedTags!.toList());
    }
    uri = RequestsUrl.addLimitFilter(uri, _quantityQuestions.toInt());

    _uriWithFilters = RequestsUrl.urlQuestionsBase + Uri.encodeFull(uri);

    var responseForRequest = await http.get(Uri.parse(_uriWithFilters));
    return responseForRequest.statusCode == 200 &&
        responseForRequest.body != "" &&
        responseForRequest.body != "[]";
  }
}