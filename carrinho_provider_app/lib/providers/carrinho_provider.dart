import 'package:flutter/foundation.dart';
import '../models/produto.dart';

class CarrinhoProvider extends ChangeNotifier {
  final List<Produto> _itens = [];
  final Map<String, int> _quantidades = {};

  bool _cupomAplicado = false;

  List<Produto> get itens => List.unmodifiable(_itens);

  int get quantidade => _itens.length;

  bool get cupomAplicado => _cupomAplicado;

  int quantidadeDoProduto(Produto produto) {
    return _quantidades[produto.id] ?? 0;
  }

  double get subtotal {
    return _itens.fold(
      0.0,
      (total, item) =>
          total + item.preco * quantidadeDoProduto(item),
    );
  }

  double get desconto {
    if (_cupomAplicado) {
      return subtotal * 0.10;
    }

    return 0.0;
  }

  double get valorTotal {
    return subtotal - desconto;
  }

  void adicionar(Produto produto) {
    if (!_itens.contains(produto)) {
      _itens.add(produto);
      _quantidades[produto.id] = 1;
    } else {
      _quantidades[produto.id] =
          quantidadeDoProduto(produto) + 1;
    }

    notifyListeners();
  }

  // EXERCÍCIO 1
  void aumentarQuantidade(Produto produto) {
    _quantidades[produto.id] =
        quantidadeDoProduto(produto) + 1;

    notifyListeners();
  }

  // EXERCÍCIO 1
  void diminuirQuantidade(Produto produto) {
    if (quantidadeDoProduto(produto) > 1) {
      _quantidades[produto.id] =
          quantidadeDoProduto(produto) - 1;
    } else {
      remover(produto);
      return;
    }

    notifyListeners();
  }

  void remover(Produto produto) {
    _itens.remove(produto);
    _quantidades.remove(produto.id);

    notifyListeners();
  }

  // EXERCÍCIO 2
  void aplicarCupom() {
    _cupomAplicado = true;

    notifyListeners();
  }

  void limpar() {
    _itens.clear();
    _quantidades.clear();
    _cupomAplicado = false;

    notifyListeners();
  }
}