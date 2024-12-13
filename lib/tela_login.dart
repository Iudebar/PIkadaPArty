import 'package:flutter/material.dart';
import 'escolha.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: TelaLogin(),
    debugShowCheckedModeBanner: false,
  ));
}

class TelaLogin extends StatefulWidget {
  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final usuario = TextEditingController(text: "emilys");
  final senha = TextEditingController(text: "emilyspass");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PicadaParty",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.grey[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Faça seu login",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(height: 20),
                    _buildUsernameField(),
                    SizedBox(height: 20),
                    _buildPasswordField(),
                    SizedBox(height: 20),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading) _buildLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: usuario,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Usuário",
        hintText: "Insira seu Usuário",
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Insira seu usuário";
        } else if (value.length < 6) {
          return "O usuário deve ter no mínimo 6 caracteres";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: senha,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Senha",
        hintText: "Insira sua Senha",
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Insira a senha";
        } else if (value.length < 5 || value.length > 15) {
          return "A senha deve ter entre 5 e 15 caracteres";
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });

          final url = Uri.parse('https://dummyjson.com/auth/login');
          final response = await http.post(
            url,
            body: {
              'username': usuario.text,
              'password': senha.text,
            },
          );

          if (response.statusCode == 200) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Escolha()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login bem-sucedido!")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Usuário ou senha incorretos'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }

          setState(() {
            isLoading = false;
          });
        }
      },
      child: Text("Login"),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
      ),
    );
  }
}
