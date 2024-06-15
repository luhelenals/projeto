import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/configs/app_settings.dart';
import 'package:projeto/models/despesa.dart';
import 'package:projeto/models/gasto_categoria.dart';
import 'package:projeto/repositories/gastomes_repository.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'home_page.dart';
import 'dart:async';
import 'dart:html';
import 'dart:js' as js;
import 'package:provider/provider.dart';
import 'package:projeto/apis/fetch_url.dart';

class AddNotaPage extends StatefulWidget {
  @override
  _AddNotaPageState createState() => _AddNotaPageState();
}

class _AddNotaPageState extends State<AddNotaPage> {
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (_) => ApiService('http://localhost:5000/extrairNota'),
      child: HtmlProvider(),
    );
  }
}

class HtmlProvider extends StatefulWidget {
  @override
  _HtmlProviderState createState() => _HtmlProviderState();
}

class _HtmlProviderState extends State<HtmlProvider> {
  String _scanResult = '';

  Future<void> _scanQRCode() async {
    final String? barcodeScanRes = await scanQRCode();
    setState(() {
      _scanResult = barcodeScanRes ?? '';
    });
  }

  Future<String?> scanQRCode() async {
    final completer = Completer<String?>();

    // Access the video element
    final video = VideoElement();

    // Access the canvas element
    final canvas = CanvasElement();
    final canvasContext = canvas.context2D;

    // Access the camera and stream the video
    try {
      final mediaDevices = window.navigator.mediaDevices;
      if (mediaDevices != null) {
        final stream = await mediaDevices.getUserMedia({'video': true});
        video.srcObject = stream;
        await video.play();
      } else {
        completer.completeError("MediaDevices not available.");
        return completer.future;
      }
    } catch (e) {
      completer.completeError("Failed to access camera: $e");
      return completer.future;
    }

    // Continuously scan the video stream for QR codes
    void scan() {
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      canvasContext.drawImage(video, 0, 0);

      final imageData = canvasContext.getImageData(0, 0, canvas.width!, canvas.height!);
      final code = js.context.callMethod('jsQR', [imageData.data, imageData.width, imageData.height]);

      if (code != null) {
        completer.complete(code['data']);
      } else {
        window.requestAnimationFrame((_) => scan());
      }
    }

    // Start scanning
    scan();

    // Return the result when scanning is complete
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.getCorFundo(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 450,
                height: 65,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppSettings.getCorTema(),
                ),
                child: Text(
                  'Aponte sua câmera para o QR Code ou digite a chave de acesso da sua nota fiscal para cadastrar seus itens automaticamente!',
                  style: TextStyle(
                    color: AppSettings.getCorSecundaria(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OndeEncontroIssoPage()),
                    );
                  },
                  child: Text(
                    'Onde encontro isso?',
                    style: TextStyle(
                      color: Colors.transparent,
                      shadows: [
                        Shadow(color: AppSettings.getCorTema(), offset: const Offset(0, -3))
                      ],
                      decoration: TextDecoration.underline,
                      decorationColor: AppSettings.getCorTema(),
                      decorationThickness: 2,
                    ),
                  )),
              const SizedBox(height: 30),
              ElevatedButton(
              onPressed: () async {
                await _scanQRCode(); // Ensure to await the function
                final url = _scanResult;
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
              child: const Text('Scan QR Code'),
            ),
            ]),
      ),
          ],
        ),
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
              backgroundColor: WidgetStateProperty.all<Color>(AppSettings.getCorFundo()),
              minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
              textStyle: WidgetStateProperty.all<TextStyle>(
                TextStyle(color: AppSettings.getCorTema()),
              ),
            ),
            child: Text(
              'Salvar',
              style: TextStyle(
                color: AppSettings.getCorTema(),
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
class OndeEncontroIssoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'A chave de acesso está localizada após o resumo da sua compra na notinha, geralmente logo acima do QR code.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Image.asset('assets/nota_exemplo.jpg'),
          ]),
      Positioned(
        top: 0,
        left: 0,
        child: IconButton(
          onPressed: () {
            // Navigate to the password reset screen
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => AddNotaPage()),
            );
          },
          icon: Icon(Icons.arrow_back, color: AppSettings.getCorTema()),
        ),
      ),
    ]));
  }
}
