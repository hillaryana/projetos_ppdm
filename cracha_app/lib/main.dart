import 'package:flutter/material.dart';

void main() {
  runApp(const MeuCrachaApp());
}

class MeuCrachaApp extends StatelessWidget {
  const MeuCrachaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPDM - Cracha Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TelaCracha(),
    );
  }
}

class TelaCracha extends StatelessWidget {
  const TelaCracha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPDM - Identificacao Estudantil'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade50,
                Colors.blue.shade100,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.indigo,
              width: 2.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Imagem real usando NetworkImage
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=47',
                ),
              ),

              const SizedBox(height: 12.0),

              const Text(
                'Ana Silva Santos',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),

              const Text(
                'Desenvolvimento Mobile / PPDM',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Divider(
                height: 24,
                thickness: 1,
              ),

              Row(
                children: const [
                  Icon(
                    Icons.badge,
                    color: Colors.indigo,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'RA: 2026109923',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 8.0),

              Row(
                children: const [
                  Icon(
                    Icons.email,
                    color: Colors.indigo,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'ana.silva@estudante.edu.br',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),

              const Divider(
                height: 24,
                thickness: 1,
              ),

              // 2. Seção Sobre Mim
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sobre Mim',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sou estudante de Desenvolvimento de Sistemas e '
                'tenho interesse em desenvolvimento de aplicativos '
                'mobile. Estou aprendendo Flutter e Dart para criar '
                'interfaces modernas e funcionais.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 16),

              // 3. Skills utilizando Chips dentro de uma Row
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Habilidades',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: const [
                  Chip(
                    label: Text('Dart'),
                    avatar: Icon(
                      Icons.code,
                      size: 18,
                    ),
                  ),
                  Chip(
                    label: Text('Flutter'),
                    avatar: Icon(
                      Icons.phone_android,
                      size: 18,
                    ),
                  ),
                  Chip(
                    label: Text('Git'),
                    avatar: Icon(
                      Icons.source,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
