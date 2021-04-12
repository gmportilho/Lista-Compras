import 'package:flutter/material.dart';
import 'package:tarefas_app/models/tarefa.model.dart';
import 'package:tarefas_app/repositories/produtos.repository.dart';
import 'package:tarefas_app/views/novo.produto.dart';

class EditaPage extends StatelessWidget {
  final _formNome = GlobalKey<FormState>();
  final _formQuant = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();
  

  void submitForm(BuildContext context, Tarefa tarefa) {
    if (_formNome.currentState.validate() && _formQuant.currentState.validate()) {
      _formNome.currentState.save();
      _formQuant.currentState.save();
      _repository.update(_tarefa, tarefa);
      Navigator.of(context).pop(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Editar Compra'),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text(
              'SALVAR',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              submitForm(context, tarefa);
            },
          ),
        ],
      ),
       body: Column(
        children:[ Form(
          key: _formNome,
          child: TextFormField(
            initialValue: tarefa.texto,
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
            initialValue: tarefa.quantidade.toString(),
            decoration: InputDecoration(
              labelText: "Quantidade",
              border: OutlineInputBorder(),
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