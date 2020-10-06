import 'package:floor_calculator/models/result_model.dart';
import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final ResultModel result;

  const ResultDialog(this.result);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Resultado'),
      content: Wrap(
        children: [
          ListTile(
            title: Text('${result.amountPieces} pisos'),
            subtitle: Text('Quantidade de pisos'),
          ),
          ListTile(
            title: Text('${result.amountFooter} pisos'),
            subtitle: Text('Quantidade de pisos para o rodapé'),
          ),
          ListTile(
            title: Text('${result.amountPiecesAndFooter} pisos'),
            subtitle: Text('Total de pisos'),
          ),
          ListTile(
            title: Text('${result.areaWithoutFooter.toStringAsFixed(2)} m²'),
            subtitle: Text('Metragem quadrada sem rodapé'),
          ),
          ListTile(
            title: Text('${result.areaWithFooter} m²'),
            subtitle: Text('Metragem quadrada com rodapé'),
          ),
          ListTile(
            title: Text('R\$ ${result.totalPrice}'),
            subtitle: Text('Preço Total'),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text('Continuar'),
          onPressed: () {},
        ),
      ],
    );
  }
}
