jimport 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/produto.dart';
import 'providers/carrinho_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CarrinhoProvider(),
      child: const CarrinhoApp(),
    ),
  );
}

class CarrinhoApp extends StatelessWidget {
  const CarrinhoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrinho com Provider',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const CatalogoScreen(),
    );
  }
}

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  final List<Produto> produtos = const [
    Produto(
      id: '1',
      nome: 'Teclado Mecânico',
      preco: 250.00,
    ),
    Produto(
      id: '2',
      nome: 'Mouse Gamer',
      preco: 120.00,
    ),
    Produto(
      id: '3',
      nome: 'Monitor 24"',
      preco: 890.00,
    ),
    Produto(
      id: '4',
      nome: 'Headset Stereo',
      preco: 180.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CarrinhoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              title: Text(
                produto.nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'R\$ ${produto.preco.toStringAsFixed(2)}',
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.teal,
                ),
                onPressed: () {
                  context
                      .read<CarrinhoProvider>()
                      .adicionar(produto);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${produto.nome} adicionado ao carrinho!',
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class CarrinhoScreen extends StatelessWidget {
  const CarrinhoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Carrinho'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CarrinhoProvider>(
        builder: (context, carrinho, child) {
          if (carrinho.itens.isEmpty) {
            return const Center(
              child: Text(
                'Seu carrinho está vazio!',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: carrinho.itens.length,
                  itemBuilder: (context, index) {
                    final produto = carrinho.itens[index];

                    final quantidade =
                        carrinho.quantidadeDoProduto(produto);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        title: Text(produto.nome),
                        subtitle: Text(
                          'R\$ ${produto.preco.toStringAsFixed(2)} cada',
                        ),
                        leading: CircleAvatar(
                          child: Text('$quantidade'),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // EXERCÍCIO 1
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                              ),
                              onPressed: () {
                                carrinho
                                    .diminuirQuantidade(produto);
                              },
                            ),

                            Text(
                              '$quantidade',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // EXERCÍCIO 1
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                              ),
                              onPressed: () {
                                carrinho
                                    .aumentarQuantidade(produto);
                              },
                            ),

                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                carrinho.remover(produto);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.teal.shade50,
                child: Column(
                  children: [
                    Text(
                      'Subtotal: R\$ ${carrinho.subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Desconto: R\$ ${carrinho.desconto.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Total: R\$ ${carrinho.valorTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // EXERCÍCIO 2
                    ElevatedButton.icon(
                      onPressed: carrinho.cupomAplicado
                          ? null
                          : () {
                              carrinho.aplicarCupom();

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Cupom de 10% aplicado!',
                                  ),
                                ),
                              );
                            },
                      icon: const Icon(
                        Icons.local_offer,
                      ),
                      label: Text(
                        carrinho.cupomAplicado
                            ? 'Cupom aplicado!'
                            : 'Aplicar cupom de 10%',
                      ),
                    ),

                    const SizedBox(height: 10),

                    // EXERCÍCIO 3
                    ElevatedButton.icon(
                      onPressed: () async {
                        final confirmar =
                            await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Limpar carrinho',
                              ),
                              content: const Text(
                                'Tem certeza que deseja '
                                'limpar o carrinho?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      false,
                                    );
                                  },
                                  child: const Text(
                                    'Cancelar',
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      true,
                                    );
                                  },
                                  child: const Text(
                                    'Confirmar',
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmar == true) {
                          carrinho.limpar();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Carrinho limpo!',
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text(
                        'Limpar carrinho',
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          carrinho.limpar();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Compra finalizada com sucesso!',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                        ),
                        child: const Text(
                          'Finalizar compra',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}