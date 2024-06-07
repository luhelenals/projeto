import 'package:flutter/material.dart';
import 'package:projeto/models/despesa.dart';
import 'package:projeto/models/gasto_categoria.dart';
import 'package:projeto/repositories/gastomes_repository.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'home_page.dart';
import 'menu_despesa.dart';

class AddDespesaPage extends StatefulWidget {
  @override
  _AddDespesaPageState createState() => _AddDespesaPageState();
}

class _AddDespesaPageState extends State<AddDespesaPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputData = InputData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
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
                  controller:
                      TextEditingController(text: _inputData.data.toString()),
                ),
                DropdownButtonFormField<enumCategoria>(
                  decoration: const InputDecoration(labelText: 'Categoria'),
                  value: _inputData.categoria.categoria,
                  items: enumCategoria.values.map((category) {
                    return DropdownMenuItem<enumCategoria>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    //setState(() {
                    _inputData.categoria = Categoria(categoria: value!);
                    //});
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: 'Forma de pagamento'),
                  items: [
                    'Cartão de crédito',
                    'Cartão de débito',
                    'Dinheiro',
                    'Pix'
                  ].map((String payment) {
                    return DropdownMenuItem<String>(
                      value: payment,
                      child: Text(payment),
                    );
                  }).toList(),
                  onChanged: (value) {
                    //setState(() {
                    _inputData.formaPagamento = value;
                    //});
                  },
                ),
                const SizedBox(height: 20.0),
                Visibility(
                  visible: _inputData.formaPagamento == '',
                  child: DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: 'Parcelamento'),
                    items: [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12'
                    ].map((String payment) {
                      return DropdownMenuItem<String>(
                        value: payment,
                        child: Text(payment),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _inputData.parcelas = int.parse(value!);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFDEFFDF)),
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(200, 50)),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        const TextStyle(color: Color(0xFF204522)),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                          color: Color(0xFF204522),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_inputData.isFilled()) {
                        GastoMensalRepository.adicionarGasto(
                            MesRepository.obterMes(_inputData.data.month).num,
                            Despesa(
                              data: _inputData.data,
                              valor: _inputData.valor,
                              descricao: _inputData.descricao.toString(),
                              categoria: _inputData.categoria,
                            ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    input: [
                                      _inputData.data,
                                      _inputData.categoria,
                                      _inputData.descricao,
                                      _inputData.valor
                                    ],
                                  )),
                        );
                      } else {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Preencha todos os campos.'),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            onPressed: () {
              // Navigate to the password reset screen
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => MenuDespesa()),
              );
            },
            icon: const Icon(Icons.arrow_back, color: Color(0xFF204522)),
          ),
        ),
      ],
    ));
  }
}

class InputData {
  String? descricao;
  double valor = 0.0;
  DateTime data = DateTime.now();
  Categoria categoria = Categoria(categoria: enumCategoria.comida);
  String? formaPagamento;
  int parcelas = 1;

  bool isFilled() {
    return descricao != null &&
        descricao!.isNotEmpty &&
        valor != 0.0 &&
        formaPagamento != null &&
        formaPagamento!.isNotEmpty;
  }
}
