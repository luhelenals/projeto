import 'package:flutter/material.dart';
import 'package:projeto/models/recebimento.dart';
import 'package:projeto/pages/add_recebimento_page.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'package:projeto/repositories/recebimentos_repository.dart';
import 'package:projeto/configs/app_settings.dart';

class MenuRecebimento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabela = RecebimentosRepository.obterRecebimentoMensal(
        MesRepository.obterMesAtual().num);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppSettings.getCorTema(),
          title: Text('Recebimentos: ${MesRepository.obterMesAtual().nome}',
              style: TextStyle(color: AppSettings.getCorSecundaria()))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text(
              'Total: R\$${tabela.valorTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 450,
              width: 400,
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int linha) {
                    return Card(
                      color: const Color(0xFFDEFFDF),
                      child: Stack(children: [
                        Column(children: [
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              tabela.listaRecebimentos[linha].descricao,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                                'Data: ${tabela.listaRecebimentos[linha].data.day.toString()}/${tabela.listaRecebimentos[linha].data.month.toString()}/${tabela.listaRecebimentos[linha].data.year.toString()}'),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                                'Valor: R\$${tabela.listaRecebimentos[linha].valor.toStringAsFixed(2)}'),
                          ),
                          const SizedBox(height: 10),
                        ]),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditarRecebimentoPopup(
                                    recebimento:
                                        tabela.listaRecebimentos[linha],
                                    onSave: (descricao, data, valor) {
                                      // Atualizar o recebimento aqui
                                      tabela.listaRecebimentos[linha]
                                          .descricao = descricao;
                                      tabela.listaRecebimentos[linha].data =
                                          data;
                                      tabela.listaRecebimentos[linha].valor =
                                          valor;
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit,
                                color: Color(0xFF204522)),
                          ),
                        ),
                      ]),
                    );
                  },
                  separatorBuilder: (_, __) =>
                      const Divider(color: Colors.transparent),
                  itemCount: tabela.listaRecebimentos.length),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(const Color(0xFFDEFFDF)),
                minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  const TextStyle(color: Color(0xFF204522)),
                ),
              ),
              child: const Text(
                'Adicionar Recebimento',
                style: TextStyle(
                    color: Color(0xFF204522),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRecebimentoPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditarRecebimentoPopup extends StatefulWidget {
  final Recebimento recebimento;
  final Function(String, DateTime, double) onSave;

  EditarRecebimentoPopup({required this.recebimento, required this.onSave});

  @override
  _EditarRecebimentoPopupState createState() => _EditarRecebimentoPopupState();
}

class _EditarRecebimentoPopupState extends State<EditarRecebimentoPopup> {
  late TextEditingController _descricaoController;
  late TextEditingController _valorController;
  late DateTime _data;

  @override
  void initState() {
    super.initState();
    _descricaoController =
        TextEditingController(text: widget.recebimento.descricao);
    _valorController =
        TextEditingController(text: widget.recebimento.valor.toString());
    _data = widget.recebimento.data;
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Recebimento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _valorController,
            decoration: InputDecoration(labelText: 'Valor'),
            keyboardType: TextInputType.number,
          ),
          ListTile(
            title: Text("Data: ${_data.day}/${_data.month}/${_data.year}"),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _data,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() {
                  _data = picked;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Salvar'),
          onPressed: () {
            String descricao = _descricaoController.text;
            double valor = double.parse(_valorController.text);
            widget.onSave(descricao, _data, valor);
          },
        ),
      ],
    );
  }
}
