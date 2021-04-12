import 'package:flutter/material.dart';
import 'package:tarefas_app/models/tarefa.model.dart';
import 'package:tarefas_app/repositories/produtos.repository.dart';

class NovaPage extends StatelessWidget {
  final _formNome = GlobalKey<FormState>();
  final _formQuant = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();

  onSave(BuildContext context) {
    if (_formNome.currentState.validate() && _formQuant.currentState.validate()) {
      _formNome.currentState.save();
      _formQuant.currentState.save(); // ~ submit do form do HTML
      _repository.create(_tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Novo Produto"),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text("SALVAR",
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () => onSave(context),
          ),
        ],
      ),
      body: Column(
        children:[ 
          Form(
          key: _formNome,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Produto",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _tarefa.texto = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
        ),
        Form(
          key: _formQuant,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Quantidade",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(20.0),
            ),
            onSaved: (value) => _tarefa.quantidade = int.parse(value),
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
        ),
      ]
      ),
    );
  }
}
