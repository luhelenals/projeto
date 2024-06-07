enum enumCategoria {
  comida,
  limpeza,
  roupas,
  saude,
  lazer,
  transporte,
  educacao,
  casa,
  outro;
}

extension CategoriaExtension on enumCategoria {
  String get name {
    switch (this) {
      case enumCategoria.comida:
        return 'Comida/bebida';
      case enumCategoria.limpeza:
        return 'Limpeza';
      case enumCategoria.roupas:
        return 'Roupa/acessório';
      case enumCategoria.saude:
        return 'Saúde/bem-estar';
      case enumCategoria.lazer:
        return 'Lazer';
      case enumCategoria.transporte:
        return 'Transporte';
      case enumCategoria.educacao:
        return 'Educação';
      case enumCategoria.casa:
        return 'Casa';
      case enumCategoria.outro:
        return 'Outro';
      default:
        return '';
    }
  }

  static enumCategoria fromString(String str) {
    switch (str) {
      case 'Comida/bebida':
        return enumCategoria.comida;
      case 'Limpeza':
        return enumCategoria.limpeza;
      case 'Roupa/acessório':
        return enumCategoria.roupas;
      case 'Saúde/bem-estar':
        return enumCategoria.saude;
      case 'Lazer':
        return enumCategoria.lazer;
      case 'Transporte':
        return enumCategoria.transporte;
      case 'Educação':
        return enumCategoria.educacao;
      case 'Casa':
        return enumCategoria.casa;
      case 'Outro':
        return enumCategoria.outro;
      default:
        throw ArgumentError('Invalid enumCategoria value');
    }
  }
}

class Categoria {
  enumCategoria categoria;
  late List<double> listaGastos;

  Categoria({required this.categoria});
}
