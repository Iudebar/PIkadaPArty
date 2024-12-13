import 'package:flutter/material.dart';
import 'escolha.dart';

void main() {
  runApp(Prevencao());
}

class Prevencao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212), // Fundo mais escuro
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Prevenção',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                _createBackRoute(),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Prevenção',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: _buildPreventionText()), // Uso do Expanded
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreventionText() {
    return SingleChildScrollView(
      child: Text(
        'Ações simples podem ajudar no combate à dengue:\n\n'
            '• Elimine copinhos plásticos, tampas de refrigerante e sacos abertos que possam acumular água.\n\n'
            '• Cubra piscinas que não estiverem em uso para evitar a proliferação dos mosquitos.\n\n'
            '• Tampar os ralos é mais uma medida recomendada.',
        style: TextStyle(fontSize: 18, color: Colors.white70),
        textAlign: TextAlign.center,
      ),
    );
  }

  Route _createBackRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Escolha(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300), // Duração da transição
    );
  }
}
