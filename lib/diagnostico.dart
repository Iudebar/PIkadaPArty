import 'package:flutter/material.dart';

class Diagnostico extends StatefulWidget {
  @override
  _DiagnosticoState createState() => _DiagnosticoState();
}

class _DiagnosticoState extends State<Diagnostico> {
  // Variáveis para armazenar as respostas (Sim/Não) para os sintomas
  bool? _temFebre;
  bool? _temDorCorpo;
  bool? _temManchasPele;
  bool? _temDorCabeca;
  bool? _temNausea;
  bool? _temCansaco;
  bool? _temVomitos;
  bool? _temDorOculos;

  // Função para calcular o diagnóstico com base nas respostas
  String _calcularDiagnostico() {
    int pontos = 0;

    // Atribuindo pontos com base na relevância do sintoma
    if (_temFebre == true) pontos += 3;  // Sintoma muito relevante, febre tem peso maior
    if (_temDorCorpo == true) pontos += 2;  // Dor no corpo é um sintoma importante
    if (_temDorOculos == true) pontos += 2;  // Dor atrás dos olhos é bem característico
    if (_temManchasPele == true) pontos += 1;  // Manchas na pele é importante, mas menor peso
    if (_temNausea == true) pontos += 1;  // Náusea é comum, mas não tão específico
    if (_temCansaco == true) pontos += 1;  // Cansaço pode ser um sintoma, mas não é específico
    if (_temVomitos == true) pontos += 1;  // Vômitos também podem ser sintoma, mas de menor peso

    // Lógica do diagnóstico com base no número total de pontos
    if (pontos <= 3) {
      return 'Improvável que você tenha dengue. Continue monitorando seus sintomas.';
    } else if (pontos <= 6) {
      return 'Possível que você tenha dengue. Procure um médico para mais esclarecimentos.';
    } else {
      return 'Quase certeza de que você tem dengue. Recomendamos procurar um médico imediatamente!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnóstico de Dengue'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Marque os sintomas que você está sentindo:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Perguntas de sintomas com melhorias estéticas
            _buildPergunta('Você tem febre?', (value) {
              setState(() {
                _temFebre = value;
              });
            }),
            _buildPergunta('Você tem dores no corpo?', (value) {
              setState(() {
                _temDorCorpo = value;
              });
            }),
            _buildPergunta('Você tem manchas vermelhas na pele?', (value) {
              setState(() {
                _temManchasPele = value;
              });
            }),
            _buildPergunta('Você tem dor de cabeça?', (value) {
              setState(() {
                _temDorCabeca = value;
              });
            }),
            _buildPergunta('Você tem náuseas?', (value) {
              setState(() {
                _temNausea = value;
              });
            }),
            _buildPergunta('Você está sentindo cansaço excessivo?', (value) {
              setState(() {
                _temCansaco = value;
              });
            }),
            _buildPergunta('Você tem vômitos?', (value) {
              setState(() {
                _temVomitos = value;
              });
            }),
            _buildPergunta('Você sente dor atrás dos olhos?', (value) {
              setState(() {
                _temDorOculos = value;
              });
            }),
            SizedBox(height: 20),
            // Botão para calcular e mostrar o diagnóstico
            ElevatedButton(
              onPressed: () {
                String resultado = _calcularDiagnostico();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Resultado do Diagnóstico'),
                    content: Text(resultado),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Fechar'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Ver Diagnóstico',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar uma pergunta com opções Sim/Não
  Widget _buildPergunta(String pergunta, ValueChanged<bool?> onChanged) {
    return Card(
      color: Color(0xFF1e1e1e),
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pergunta,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Sim', style: TextStyle(color: Colors.white)),
                    value: true,
                    groupValue: null,
                    onChanged: onChanged,
                    activeColor: Colors.green,
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Não', style: TextStyle(color: Colors.white)),
                    value: false,
                    groupValue: null,
                    onChanged: onChanged,
                    activeColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
