import 'package:flutter/material.dart';
import 'package:tarefas_app/models/tarefa.model.dart';
import 'package:tarefas_app/repositories/produtos.repository.dart';
import 'package:tarefas_app/views/novo.produto.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final repository = TarefaRepository();

  List<Tarefa> tarefas;

  @override
  initState() {
    super.initState();
    this.tarefas = repository.read();
  }

  void sort() {
    tarefas.sort((a, b) => a.finalizada ? 1 : -1);
  }

  Future adicionarTarefa(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/nova');
    if (result == true) {
      setState(() {
        this.tarefas = repository.read();
      });
    }
  }

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: Text("Lista de Compras"),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => setState(() => canEdit = !canEdit))
          ]),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, indice) {
          var tarefa = tarefas[indice];
          return Dismissible(
            key: Key(tarefa.texto),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (_) => repository.delete(tarefa.texto),
            child: CheckboxListTile(
              tristate: true,
              activeColor: Colors.black,
              value: tarefa.finalizada,
              
              title: Row(
                children: [
                  canEdit
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            var result = await Navigator.of(context)
                                .pushNamed('/edita', arguments: tarefa);
                            if (result) {
                              setState(() => this.tarefas = repository.read());
                            }
                            ;
                          })
                      : Container(),
                  Text(tarefa.texto,
                      style: TextStyle(
                          decoration: tarefa.finalizada
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  IconButton(icon: Icon(Icons.cancel),
                  onPressed: ,
                  )
                ],
              ),
              subtitle: Text("Quantidade  " + tarefa.quantidade.toString()),
              onChanged: (value) {
                setState(() => tarefa.finalizada = value);
                sort();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () => adicionarTarefa(context),
      ),
    );
  }
}
