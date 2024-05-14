import 'package:flutter/material.dart';
import 'package:projeto/pages/menu_despesa.dart';
import 'home_page.dart';

class AddNotaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
                    // Navigate to the password reset screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OndeEncontroIssoPage()),
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
                  )),
              const SizedBox(height: 30),
              Container(
                width: 300,
                height: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ]),
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
    ]));
  }
}

class ResumoNotaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            const Text(
              'Resumo das suas compras',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF204522),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450, maxHeight: 500),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF204522),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(
                        0xFF204522,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: [
                          Text(
                            'Item',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 150),
                          Text(
                            'Valor',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 60),
                          Text(
                            'Categoria',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ]),
                        SizedBox(height: 10.0),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white), // Set text color to white
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Another long text:',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white), // Set text color to white
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla auctor augue a lectus suscipit, eget finibus quam eleifend. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec accumsan ligula libero, quis accumsan tortor dictum at. Suspendisse potenti. In hac habitasse platea dictumst. Sed in libero vestibulum, sollicitudin odio sit amet, faucibus mauris. Aenean dictum laoreet diam eu sagittis. Integer ut purus vehicula, eleifend tellus quis, efficitur nulla. Suspendisse malesuada ligula eu arcu egestas, non scelerisque nisi efficitur.',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white), // Set text color to white
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFDEFFDF)),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(200, 50)),
                textStyle: MaterialStateProperty.all<TextStyle>(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(input: [])),
                );
              },
            ),
          ])),
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
          icon: const Icon(Icons.arrow_back, color: Color(0xFF204522)),
        ),
      ),
    ]));
  }
}
