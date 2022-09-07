import 'package:flutter/material.dart';
import 'package:quiz/utils/app_routes.dart';

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
  final Set<String> _selectedTags = {};
  Set<String> _selectedCategory = {};
  String _selectedDifficulty = "";
  double _quantityQuestions = 10;

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
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.randomQuestions),
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
        onChanged: (e) => setState(
            () => _selectedCategory = Set.from(widget.categories[e as String])),
      ),
      const SizedBox(height: 24),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          label: Text("Tags"),
          hintText: "Selecione as Tags",
          border: OutlineInputBorder(),
        ),
        items: _createDropDownItems(tags),
        onChanged: (e) => setState(() => _selectedTags.add(e.toString())),
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
}
