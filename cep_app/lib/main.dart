import 'package:flutter/material.dart';
import 'models/endereco.dart';
import 'services/via_cep_service.dart';

void main() {
  runApp(const CepApp());
}

class CepApp extends StatelessWidget {
  const CepApp({super.key});

@override
Widget build(BuildContext context) {
  return materialApp(
    title: 'Consulta CEP',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      useMaterial3: true,
    ),
    home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cepController = TextEditingController();
  Endereco? _endereco;
  bool _isLoading = false;
String? _errorMessage;

Future<void> _buscarEndereco() async {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  try {
    final resultado = await ViaCepService.buscarECep(_cepController.text);
    setState(() {
      _endereco = resultado;
    });
  } catch (e) {
    setState(() {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

@override
void dispose() {
  cepController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Consulta CEP (ViaCep API)'), 
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: cepController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Informa o CEP (somente números)',
              hinText: 'Ex: 01001000',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _consultarCep,
            icon: const Icon(Icons.search),
            label: const Text('Buscar Endereço'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 1),

            ),
          ),
          conts SizedBox(height: 24),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          if (_errorMessage!= null)
          Card(
            color: Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ),
        if (_endereco != null)
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  '${_enderecoResult!.logradouro}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Bairro: ${_enderecoResult!.bairro}'),
                const SizedBox(height: 8),
                Text('Cidade/UF: ${_enderecoResult!.localidade}/${_enderecoResult!.uf}'),
                Text('CEP: ${_enderecoResult!.cep}'),
              ],
            ),
          ),
        ),
      ],
    ),  
  ),
);
}
}




  





