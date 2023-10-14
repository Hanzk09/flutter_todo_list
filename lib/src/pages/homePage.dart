import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _todoController = TextEditingController();
  List _todos = [];
  late Map<String, dynamic> _lastRemoved;
  late int _indexLastRemoved;

  void _addTodo() {
    setState(() {
      _todos.add({"title": _todoController.text, "check": false});
      _todoController.clear();
      _saveData();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _todos.sort(
        (a, b) {
          if (a["check"] && !b["check"]) {
            return 1;
          } else if (!a["check"] && b["check"]) {
            return -1;
          } else {
            return 0;
          }
        },
      );
      _saveData();
    });
  }

  @override
  void initState() {
    super.initState();
    _readData().then((value) {
      setState(() {
        _todos = json.decode(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Lista de Tarefas",
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          labelText: "Nova Tarefa",
                          labelStyle: TextStyle(color: Colors.blueAccent)),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: _addTodo,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                    child: const Text("ADD"),
                  )
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: _todos.length,
                  itemBuilder: _buildItem,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_todos[index]["title"]),
        secondary: CircleAvatar(
          child: _todos[index]["check"]
              ? const Icon(Icons.check)
              : const Icon(Icons.error),
        ),
        value: _todos[index]["check"],
        onChanged: (value) {
          setState(() {
            _todos[index]["check"] = value;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = _todos[index];
          _indexLastRemoved = index;
          _todos.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _todos.insert(_indexLastRemoved, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_todos);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
