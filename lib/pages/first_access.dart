import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';

class FirstAccessScreen extends StatelessWidget {
  const FirstAccessScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nome',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Data de nascimento',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Senha',
                  fillColor: Colors.white,
                  filled: true,
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirmar senha',
                  fillColor: Colors.white,
                  filled: true,
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
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
                'Criar conta',
                style: TextStyle(
                    color: Color(0xFF204522),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Ação quando o botão é pressionado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            input: [],
                          )),
                );
              },
            ),
          ]),
      Positioned(
        top: 0,
        left: 0,
        child: IconButton(
          onPressed: () {
            // Navigate to the password reset screen
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const LogInPage()),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF204522)),
        ),
      ),
    ]));
  }
}

/*
class FirstAccessInfoScreen extends StatelessWidget {
  const FirstAccessInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Agora vamos falar um pouco sobre você!',
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF204522)),
          ),
          const SizedBox(height: 30),
          Center(
              child: Container(
            width: 450,
            height: 270,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF204522),
            ),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Renda fixa',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(width: 300),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.help_outline),
                        color: Colors.white,
                        onPressed: () {
                          // Show popup message
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Renda fixa:"),
                                content: const Text(
                                    "Renda fixa pode ser considerada qualquer quantia que não varie de um mês para o outro, como por exemplo, um salário fixo ou bolsa auxílio. Você pode alterá-lo depois."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Salário fixo, mesada...',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Valor',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  '+  Adicionar outra',
                  style: TextStyle(
                    color: Colors.transparent,
                    shadows: [
                      Shadow(color: Color(0xFFDEFFDF), offset: Offset(0, -3))
                    ],
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFDEFFDF),
                    decorationThickness: 2,
                  ),
                ),
                onPressed: () {
                  //
                },
              ),
            ]),
          )),
          const SizedBox(height: 30),
          Center(
              child: Container(
            width: 450,
            height: 270,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF204522),
            ),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Despesas fixas',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(width: 260),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.help_outline),
                        color: Colors.white,
                        onPressed: () {
                          // Show popup message
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Despesas fixas:"),
                                content: const Text(
                                    "Alguns exemplos de despesas fixas podem ser seu aluguel, contas de internet ou assinatura de algum streaming, que não mudam de um mês para o outro. Você também pode alterá-lo depois."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Aluguel, assinatura...',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Valor',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  '+  Adicionar outra',
                  style: TextStyle(
                    color: Colors.transparent,
                    shadows: [
                      Shadow(color: Color(0xFFDEFFDF), offset: Offset(0, -3))
                    ],
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFDEFFDF),
                    decorationThickness: 2,
                  ),
                ),
                onPressed: () {
                  //
                },
              ),
            ]),
          )),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFDEFFDF)),
              minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(color: Color(0xFF204522)),
              ),
            ),
            child: const Text(
              'Continuar',
              style: TextStyle(
                  color: Color(0xFF204522),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FirstAccessInfoScreen2()),
              );
            },
          ),
        ],
      )
    ]));
  }
}

class FirstAccessInfoScreen2 extends StatelessWidget {
  const FirstAccessInfoScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Agora vamos falar um pouco sobre você!',
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF204522)),
          ),
          const SizedBox(height: 30),
          Center(
              child: Container(
            width: 450,
            height: 270,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF204522),
            ),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Renda variável',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(width: 275),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.help_outline),
                        color: Colors.white,
                        onPressed: () {
                          // Show popup message
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Renda variável:"),
                                content: const Text(
                                    "Se você recebe algo que mude de um mês para o outro você pode inserir essa renda aqui. Elas podem ser seu salário ou comissões de venda, por exemplo. Você pode inserir o que recebeu ou receberá neste mês e atualizar este valor depois."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Salário, comissão...',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Valor',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  '+  Adicionar outra',
                  style: TextStyle(
                    color: Colors.transparent,
                    shadows: [
                      Shadow(color: Color(0xFFDEFFDF), offset: Offset(0, -3))
                    ],
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFDEFFDF),
                    decorationThickness: 2,
                  ),
                ),
                onPressed: () {
                  //
                },
              ),
            ]),
          )),
          const SizedBox(height: 30),
          Center(
              child: Container(
            width: 450,
            height: 270,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF204522),
            ),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Despesas variáveis',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(width: 235),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.help_outline),
                        color: Colors.white,
                        onPressed: () {
                          // Show popup message
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Despesas variáveis:"),
                                content: const Text(
                                    "Alguns exemplos de despesas variáveis são contas de água e energia ou qualquer outra coisa que você pague em diferentes quantidades mês a mês."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Conta de água, energia...',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Valor',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  '+  Adicionar outra',
                  style: TextStyle(
                    color: Colors.transparent,
                    shadows: [
                      Shadow(color: Color(0xFFDEFFDF), offset: Offset(0, -3))
                    ],
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFDEFFDF),
                    decorationThickness: 2,
                  ),
                ),
                onPressed: () {
                  //
                },
              ),
            ]),
          )),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFDEFFDF)),
              minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(color: Color(0xFF204522)),
              ),
            ),
            child: const Text(
              'Continuar',
              style: TextStyle(
                  color: Color(0xFF204522),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          input: [],
                        )),
              );
            },
          ),
        ],
      )
    ]));
  }
}

 */