import 'package:flutter/material.dart';
import 'package:projeto/models/recebimento.dart';
import 'package:projeto/pages/home_page.dart';
import 'package:projeto/pages/menu_recebimento.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'package:projeto/repositories/recebimentos_repository.dart';

class AddRecebimentoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color(0xFFBADBC0), // Set the background color here
        child: _AddRecebimentoPageContent(),
      ),
    );
  }
}

class _AddRecebimentoPageContent extends StatefulWidget {
  @override
  __AddRecebimentoPageContentState createState() =>
      __AddRecebimentoPageContentState();
}

class __AddRecebimentoPageContentState
    extends State<_AddRecebimentoPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _inputData = InputData();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    onChanged: (value) {
                      _inputData.descricao = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Valor'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _inputData.valor = double.parse(value);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Data'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _inputData.data = selectedDate;
                        });
                      }
                    },
                    controller: TextEditingController(
                      text: _inputData.data != null
                          ? _inputData.data!.toString()
                          : '',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFDEFFDF),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(200, 50),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(
                              color: Color(0xFF204522),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                            color: Color(0xFF204522),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (_inputData.isFilled()) {
                            RecebimentosRepository.adicionarRecebimento(
                                MesRepository.obterMes(_inputData.data!.month)
                                    .num,
                                Recebimento(
                                    valor: _inputData.valor,
                                    data: _inputData.data!,
                                    descricao: _inputData.descricao!));
                            _formKey.currentState!.save();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                  input: [
                                    _inputData.descricao,
                                    _inputData.valor,
                                    _inputData.data,
                                  ],
                                ),
                              ),
                            ).then((value) {
                              // This part runs when you pop the DashboardPage
                              // Update your data here, for example:
                              setState(() {});
                            });
                          } else {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      const Text('Preencha todos os campos.'),
                                  actions: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Positioned(
        top: 0,
        left: 0,
        child: IconButton(
          onPressed: () {
            // Navigate to the password reset screen
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => MenuRecebimento()),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF204522)),
        ),
      ),
    ]));
  }
}

class InputData {
  String? descricao;
  double valor = 0.0;
  DateTime? data;

  bool isFilled() {
    return descricao != null && descricao!.isNotEmpty && valor != 0.0;
  }
}
