import 'package:flutter/material.dart';
import 'package:projeto/configs/app_settings.dart';
import 'package:projeto/models/despesa.dart';
import 'package:projeto/models/gasto_categoria.dart';
import 'package:projeto/pages/home_page.dart';
import 'package:projeto/repositories/gastomes_repository.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'add_nota.dart';
import 'package:provider/provider.dart';
import 'package:projeto/apis/fetch_url.dart';
import 'package:intl/intl.dart';


class ChaveDeAcessoPage extends StatefulWidget {
  @override
  _ChaveDeAcessoPageState createState() => _ChaveDeAcessoPageState();
}

class _ChaveDeAcessoPageState extends State<ChaveDeAcessoPage> {
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (_) => ApiService('http://localhost:5000/extrairNota'),
      builder: (context, child) {
        return HtmlProvider();
      },
    );
  }
}

class HtmlProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    final TextEditingController urlController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 450,
                height: 65,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF204522),
                ),
                child: const Text(
                  'Aponte sua câmera para o QR Code ou digite a chave de acesso da sua nota fiscal para cadastrar seus itens automaticamente!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OndeEncontroIssoPage()),
                  );
                },
                child: const Text(
                  'Onde encontro isso?',
                  style: TextStyle(
                    color: Colors.transparent,
                    shadows: [
                      Shadow(color: Color(0xFF204522), offset: Offset(0, -3))
                    ],
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF204522),
                    decorationThickness: 2,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Chave de acesso',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFDEFFDF)),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
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
                onPressed: () async {
                  final url = urlController.text;
                  if (url.isNotEmpty) {
                    try {
                      final Map<String, dynamic> content = await apiService.fetchContent(url);
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResumoNotaPage(content: content),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to fetch content: $e')),
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => AddNotaPage()),
                );
              },
              icon: const Icon(Icons.arrow_back, color: Color(0xFF204522)),
            ),
          ),
        ],
      ),
    );
  }
}

class ResumoNotaPage extends StatefulWidget {
  final Map<String, dynamic> content;

  ResumoNotaPage({required this.content});

  @override
  _ResumoNotaPageState createState() => _ResumoNotaPageState();
}

class _ResumoNotaPageState extends State<ResumoNotaPage> {
  late List<dynamic> produtos;
  late List<dynamic> precos;
  late String data;
  late List<dynamic> categorias;

  @override
  void initState() {
    super.initState();
    produtos = widget.content['produtos'];
    precos = widget.content['preços'];
    data = widget.content['data'];
    categorias = widget.content['categoria'];
  }

  void _editarCategoria(int index) async {
    String? novaCategoria = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return EditarCategoriaPopup(
          categoriaAtual: categorias[index],
        );
      },
    );

    if (novaCategoria != null && novaCategoria.isNotEmpty) {
      setState(() {
        categorias[index] = novaCategoria;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo das compras de $data', style: TextStyle(color: AppSettings.getCorSecundaria())),
        backgroundColor: AppSettings.getCorTema(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(produtos[index].toString()),
                  subtitle: Text(categorias[index]),
                  trailing: Text('R\$${precos[index]}', style: const TextStyle(fontSize: 20)),
                  onTap: () {
                    _editarCategoria(index);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFDEFFDF)),
              minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
              textStyle: WidgetStateProperty.all<TextStyle>(
                const TextStyle(color: Color(0xFF204522)),
              ),
            ),
            child: const Text(
              'Salvar',
              style: TextStyle(
                color: Color(0xFF204522),
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () {
              DateTime dataFormated = DateFormat('dd/MM/yyyy').parse(data);
              for(int i = 0; i < produtos.length; i++) {
                GastoMensalRepository.adicionarGasto(
                  MesRepository.obterMes(dataFormated.month).num,
                  Despesa(
                    data: dataFormated,
                    valor: double.parse(precos[i].replaceAll(',', '.')),
                    descricao: produtos[i],
                    categoria: Categoria(categoria: CategoriaExtension.fromString(categorias[i])),
                    exibir: false
                  ));
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(input: [])),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class EditarCategoriaPopup extends StatelessWidget {
  final String categoriaAtual;

  EditarCategoriaPopup({required this.categoriaAtual});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Categoria'),
      content: DropdownButtonFormField<String>(
        value: categoriaAtual,
        items: enumCategoria.values.map((enumCategoria categoria) {
          return DropdownMenuItem<String>(
            value: categoria.name,
            child: Text(categoria.name),
          );
        }).toList(),
        onChanged: (String? newValue) {
          Navigator.of(context).pop(newValue);
        },
      ),
    );
  }
}