import 'package:tarefas_app/models/tarefa.model.dart';

class TarefaRepository {
  static List<Tarefa> tarefas = List<Tarefa>();

  TarefaRepository() {
    if (tarefas.isEmpty) {
      tarefas.add(Tarefa(
          id: "1", texto: "Café", quantidade: 2, finalizada: false));
      tarefas.add(
          Tarefa(id: "2", texto: "Coca Cola", quantidade: 6, finalizada: false));
      tarefas.add(Tarefa(
          id: "3", texto: "Óleo", quantidade: 3, finalizada: false));
    }
  }

  void create(Tarefa tarefa) {
    tarefas.add(tarefa);
  }

  List<Tarefa> read() {
    return tarefas;
  }

  void delete(String texto) {
    final tarefa = tarefas.singleWhere((t) => t.texto == texto);
    tarefas.remove(tarefa);
  }

  void update(Tarefa newTarefa, Tarefa oldTarefa) {
    final tarefa = tarefas.singleWhere((t) => t.texto == oldTarefa.texto);
    tarefa.texto = newTarefa.texto;
    tarefa.quantidade = newTarefa.quantidade;
  }
}
