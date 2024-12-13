import 'package:flutter/material.dart';
import 'escolha.dart';

void main() {
  runApp(Sintomas());
}

class Sintomas extends StatelessWidget {
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
            'Sintomas',
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
                  'Sintomas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: _buildSymptomsList()), // Use Expanded para evitar overflow
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomsList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSymptomItem('Dor abdominal intensa'),
          _buildSymptomItem('Vômitos persistentes'),
          _buildSymptomItem('Respiração ofegante'),
          _buildSymptomItem('Sangramento de mucosas'),
          _buildSymptomItem('Fadiga'),
          _buildSymptomItem('Vômito de sangue'),
          _buildSymptomItem('Desidratação e sensação de boca seca'),
          _buildSymptomItem('Pele pálida'),
        ],
      ),
    );
  }

  Widget _buildSymptomItem(String symptom) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_right,
            color: Colors.blueAccent,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              symptom,
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Route _createBackRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Escolha(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Começa da esquerda
        const end = Offset.zero; // Fim na posição original
        const curve = Curves.easeInOut; // Curva da animação

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
